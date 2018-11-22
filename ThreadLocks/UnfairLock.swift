//
//  UnfairLock.swift
//  SwiftExt
//
//  Created by WeZZard on 12/12/17.
//

import os

@available(macOSApplicationExtension 10.12, *)
@available(iOSApplicationExtension 10.0, *)
@available(tvOSApplicationExtension 10.0, *)
@available(watchOSApplicationExtension 3.0, *)
public class UnfairLock {
    internal var _impl: os_unfair_lock
    
    public let name: String
    
    public init(name: String) {
        self.name = name
        _impl = os_unfair_lock()
    }
    
    public init(
        file: StaticString = #file,
        line: Int = #line,
        function: StaticString = #function
        )
    {
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
    public func waitToAcquireAndPerform<R>(
        closure: () throws -> R
        )
        rethrows
        -> R
    {
        _waitToLock()
        let returned = try closure()
        _unlock()
        return returned
    }
    
    /// Try to acquire an unfair lock.
    public func tryToAcquireAndPerform<R>(
        closure: () throws -> R
        )
        rethrows
        -> R?
    {
        if _tryToLock() {
            let returned = try closure()
            _unlock()
            return returned
        }
        return nil
    }
    
    /// Try to acquire an unfair lock.
    public func tryToAcquireAndPerform(
        closure: () throws -> Void
        )
        rethrows
        -> Bool
    {
        if _tryToLock() {
            try closure()
            _unlock()
            return true
        }
        return false
    }
}
