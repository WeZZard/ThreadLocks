//
//  UnfairLocked.swift
//  SwiftExt
//
//  Created by WeZZard on 12/12/17.
//

import os

@available(macOSApplicationExtension 10.12, *)
@available(iOSApplicationExtension 10.0, *)
@available(tvOSApplicationExtension 10.0, *)
@available(watchOSApplicationExtension 3.0, *)
public class UnfairLocked<R> {
    internal var _impl: os_unfair_lock
    
    public typealias Resource = R
    
    public var resource: Resource {
        get { return withContentAndWait { return $0 } }
        set { withMutableContentAndWait { $0 = newValue } }
    }
    
    internal var _resource_: Resource
    
    public let name: String
    
    public init(resource: Resource, name: String) {
        _resource_ = resource
        self.name = name
        _impl = os_unfair_lock()
    }
    
    public init(
        resource: Resource,
        file: StaticString = #file,
        line: Int = #line,
        function: StaticString = #function
        )
    {
        _resource_ = resource
        self.name = "File: \"\(file)\" at line: \(line). Function: \"\(function)\""
        _impl = os_unfair_lock()
    }
    
    @inline(__always)
    internal func _waitToLock() {
        while !_tryToLock() { }
    }
    
    @inline(__always)
    internal func _tryToLock() -> Bool {
        return os_unfair_lock_trylock(&_impl)
    }
    
    @inline(__always)
    internal func _unlock() {
        os_unfair_lock_unlock(&_impl)
    }
    
    /// Wait to acquire an unfair lock.
    public func withContentAndWait<R>(
        closure: (Resource) throws -> R
        )
        rethrows
        -> R
    {
        _waitToLock()
        let returned = try closure(_resource_)
        _unlock()
        return returned
    }
    
    /// Try to acquire an unfair lock.
    public func withContentOrFail<R>(
        closure: (Resource) throws -> R
        )
        rethrows
        -> R?
    {
        if _tryToLock() {
            let returned = try closure(_resource_)
            _unlock()
            return returned
        }
        return nil
    }
    
    /// Try to acquire an unfair lock.
    public func withContentOrFail(
        closure: (Resource) throws -> Void
        )
        rethrows
        -> Bool
    {
        if _tryToLock() {
            try closure(_resource_)
            _unlock()
            return true
        }
        return false
    }
    
    /// Wait to acquire an unfair lock.
    public func withMutableContentAndWait<R>(
        closure: (inout Resource) throws -> R
        )
        rethrows
        -> R
    {
        _waitToLock()
        let returned = try closure(&_resource_)
        _unlock()
        return returned
    }
    
    /// Try to acquire an unfair lock.
    public func withMutableContentOrFail<R>(
        closure: (inout Resource) throws -> R
        )
        rethrows
        -> R?
    {
        if _tryToLock() {
            let returned = try closure(&_resource_)
            _unlock()
            return returned
        }
        return nil
    }
    
    /// Try to acquire an unfair lock.
    public func withMutableContentOrFail(
        closure: (inout Resource) throws -> Void
        )
        rethrows
        -> Bool
    {
        if _tryToLock() {
            try closure(&_resource_)
            _unlock()
            return true
        }
        return false
    }
}


extension UnfairLocked: Equatable where R: Equatable {
    @available(macOSApplicationExtension 10.12, *)
    @available(iOSApplicationExtension 10.0, *)
    @available(tvOSApplicationExtension 10.0, *)
    @available(watchOSApplicationExtension 3.0, *)
    public static func == (lhs: UnfairLocked, rhs: UnfairLocked) -> Bool {
        return lhs.withContentAndWait { (lhs) -> Bool in
            rhs.withContentAndWait { (rhs) -> Bool in
                return rhs == lhs
            }
        }
    }
}
