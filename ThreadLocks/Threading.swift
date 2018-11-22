//
//  Threading.swift
//  SwiftExt
//
//  This is an auto-generated file. Do not modify it manually.

import Darwin

//MARK: Mutex and Recursive Lock
/// `MutexLocked` provides an error check mutex lock infrastructure in 
/// scope of type.
public class MutexLocked<L> {
    public typealias Locked = L
    private typealias Impl = MutexLockedImpl<L>

    public init(locked: Locked, name: String = "") throws {
        _impl = try Impl(locked: locked, name: name, type: .errorCheck)
    }
	
	/// Wait to acquire an error check mutex lock.
    public func withContentAndWait<R>(
		closure: (Locked) throws -> R
		)
        rethrows
        -> R
    {
        _impl.waitToLock()
        let returned = try closure(_impl.locked)
        _impl.unlock()
        return returned
    }
	
	/// Try to acquire an error check mutex lock.
    public func withContentOrFail<R>(
		closure: (Locked) throws -> R
		)
        rethrows
        -> R?
    {
        if _impl.tryToLock() {
            let returned = try closure(_impl.locked)
            _impl.unlock()
            return returned
        }
        return nil
    }
	
	/// Try to acquire an error check mutex lock.
    public func withContentOrFail(
		closure: (Locked) throws -> Void
		)
        rethrows
        -> Bool
    {
        if _impl.tryToLock() {
            try closure(_impl.locked)
            _impl.unlock()
            return true
        }
        return false
    }
	
	/// Wait to acquire an error check mutex lock.
    public func withMutableContentAndWait<R>(
		closure: (inout Locked) throws -> R
		)
        rethrows
        -> R
    {
        _impl.waitToLock()
        let returned = try closure(&_impl.locked)
        _impl.unlock()
        return returned
    }
	
	/// Try to acquire an error check mutex lock.
    public func withMutableContentOrFail<R>(
		closure: (inout Locked) throws -> R
		)
        rethrows
        -> R?
    {
        if _impl.tryToLock() {
            let returned = try closure(&_impl.locked)
            _impl.unlock()
            return returned
        }
        return nil
    }
	
	/// Try to acquire an error check mutex lock.
    public func withMutableContentOrFail(
		closure: (inout Locked) throws -> Void
		)
        rethrows
        -> Bool
    {
        if _impl.tryToLock() {
            try closure(&_impl.locked)
            _impl.unlock()
            return true
        }
        return false
    }
    
    private let _impl: Impl
}


extension MutexLocked: Equatable where L: Equatable {
    public static func == (lhs: MutexLocked, rhs: MutexLocked)
	    -> Bool
    {
	    return lhs.withContentAndWait { (lhs) -> Bool in
		    rhs.withContentAndWait { (rhs) -> Bool in
			    return rhs == lhs
		    }
	    }
    }
}


/// `RecursiveLocked` provides a recursive mutex lock infrastructure in 
/// scope of type.
public class RecursiveLocked<L> {
    public typealias Locked = L
    private typealias Impl = MutexLockedImpl<L>

    public init(locked: Locked, name: String = "") throws {
        _impl = try Impl(locked: locked, name: name, type: .recursive)
    }
	
	/// Wait to acquire a recursive mutex lock.
    public func withContentAndWait<R>(
		closure: (Locked) throws -> R
		)
        rethrows
        -> R
    {
        _impl.waitToLock()
        let returned = try closure(_impl.locked)
        _impl.unlock()
        return returned
    }
	
	/// Try to acquire a recursive mutex lock.
    public func withContentOrFail<R>(
		closure: (Locked) throws -> R
		)
        rethrows
        -> R?
    {
        if _impl.tryToLock() {
            let returned = try closure(_impl.locked)
            _impl.unlock()
            return returned
        }
        return nil
    }
	
	/// Try to acquire a recursive mutex lock.
    public func withContentOrFail(
		closure: (Locked) throws -> Void
		)
        rethrows
        -> Bool
    {
        if _impl.tryToLock() {
            try closure(_impl.locked)
            _impl.unlock()
            return true
        }
        return false
    }
	
	/// Wait to acquire a recursive mutex lock.
    public func withMutableContentAndWait<R>(
		closure: (inout Locked) throws -> R
		)
        rethrows
        -> R
    {
        _impl.waitToLock()
        let returned = try closure(&_impl.locked)
        _impl.unlock()
        return returned
    }
	
	/// Try to acquire a recursive mutex lock.
    public func withMutableContentOrFail<R>(
		closure: (inout Locked) throws -> R
		)
        rethrows
        -> R?
    {
        if _impl.tryToLock() {
            let returned = try closure(&_impl.locked)
            _impl.unlock()
            return returned
        }
        return nil
    }
	
	/// Try to acquire a recursive mutex lock.
    public func withMutableContentOrFail(
		closure: (inout Locked) throws -> Void
		)
        rethrows
        -> Bool
    {
        if _impl.tryToLock() {
            try closure(&_impl.locked)
            _impl.unlock()
            return true
        }
        return false
    }
    
    private let _impl: Impl
}


extension RecursiveLocked: Equatable where L: Equatable {
    public static func == (lhs: RecursiveLocked, rhs: RecursiveLocked)
	    -> Bool
    {
	    return lhs.withContentAndWait { (lhs) -> Bool in
		    rhs.withContentAndWait { (rhs) -> Bool in
			    return rhs == lhs
		    }
	    }
    }
}


/// `MutexLock` provides an error check mutex lock infrastructure in 
/// scope of function.
public class MutexLock {
    private typealias Impl = MutexLockImpl

    public init(name: String = "") throws {
        _impl = try Impl(name: name, type: .errorCheck)
    }
	
	/// Wait to acquire an error check mutex lock.
    public func waitToAcquireAndPerform<R>(
		closure: () throws -> R
		)
        rethrows
        -> R
    {
        _impl.waitToLock()
        let returned = try closure()
        _impl.unlock()
        return returned
    }
	
	/// Try to acquire an error check mutex lock.
    public func tryToAcquireAndPerform<R>(
		closure: () throws -> R
		)
        rethrows
        -> R?
    {
        if _impl.tryToLock() {
            let returned = try closure()
            _impl.unlock()
            return returned
        }
        return nil
    }
	
	/// Try to acquire an error check mutex lock.
    public func tryToAcquireAndPerform(
		closure: () throws -> Void
		)
        rethrows
        -> Bool
    {
        if _impl.tryToLock() {
            try closure()
            _impl.unlock()
            return true
        }
        return false
    }
    
    private let _impl: Impl
}


/// `RecursiveLock` provides a recursive mutex lock infrastructure in 
/// scope of function.
public class RecursiveLock {
    private typealias Impl = MutexLockImpl

    public init(name: String = "") throws {
        _impl = try Impl(name: name, type: .recursive)
    }
	
	/// Wait to acquire a recursive mutex lock.
    public func waitToAcquireAndPerform<R>(
		closure: () throws -> R
		)
        rethrows
        -> R
    {
        _impl.waitToLock()
        let returned = try closure()
        _impl.unlock()
        return returned
    }
	
	/// Try to acquire a recursive mutex lock.
    public func tryToAcquireAndPerform<R>(
		closure: () throws -> R
		)
        rethrows
        -> R?
    {
        if _impl.tryToLock() {
            let returned = try closure()
            _impl.unlock()
            return returned
        }
        return nil
    }
	
	/// Try to acquire a recursive mutex lock.
    public func tryToAcquireAndPerform(
		closure: () throws -> Void
		)
        rethrows
        -> Bool
    {
        if _impl.tryToLock() {
            try closure()
            _impl.unlock()
            return true
        }
        return false
    }
    
    private let _impl: Impl
}



//MARK: Mutex Locks Implementation
internal final class MutexLockedImpl<L> {
    internal typealias Locked = L

    internal var locked: Locked
    
    internal init(locked: Locked, name: String, type: MutexType) throws {
        self.locked = locked
        self.name = name
        
        _mutexPtr = .allocate(capacity: 1)
        
        var mutexattr = pthread_mutexattr_t()
        
        switch pthread_mutexattr_init(&mutexattr) {
        case ENOMEM:    throw InitError.outOfMemory
        default:        break
        }
        
        precondition(
            pthread_mutexattr_settype(&mutexattr,type.pthreadType) != EINVAL,
            "\(pthread_mutexattr_settype): Invalid value for attr, or invalid value for type."
        )
        
        switch pthread_mutex_init(_mutexPtr, &mutexattr) {
        case EAGAIN:    throw InitError.lackOfSystemResource
        case ENOMEM:    throw InitError.outOfMemory
        case EINVAL:    preconditionFailure("\(pthread_mutex_init): The value specified by attr is invalid.")
        default: break
        }
    }
    
    internal typealias InitError = MutexInitError
    
    internal var name: String
    
    private var _mutexPtr: UnsafeMutablePointer<pthread_mutex_t>
    
    deinit {
        pthread_mutex_destroy(_mutexPtr)
        _mutexPtr.deinitialize(count: 1)
        _mutexPtr.deallocate()
    }
    
    internal func tryToLock() -> Bool {
        switch pthread_mutex_trylock(_mutexPtr) {
        case EINVAL:
            preconditionFailure("\(self): The value specified by mutex is invalid.")
        case 0:
            return true
        default:
            return false
        }
    }
    
    internal func waitToLock() {
        var mutex_trylock_result = pthread_mutex_trylock(_mutexPtr)
        while mutex_trylock_result != 0 {
            precondition(
                mutex_trylock_result != EINVAL,
                "\(self): The value specified by mutex is invalid."
            )
            mutex_trylock_result = pthread_mutex_trylock(_mutexPtr)
        }
    }
    
    internal func unlock() {
        switch pthread_mutex_unlock(_mutexPtr) {
        case EINVAL:
            preconditionFailure("\(self): The value specified by mutex is invalid.")
        case EPERM:
            preconditionFailure("\(self): The current thread does not hold a lock on mutex.")
        default: break
        }
    }
}

internal final class MutexLockImpl {
    internal init(name: String, type: MutexType) throws {
        self.name = name
        
        _mutexPtr = .allocate(capacity: 1)
        
        var mutexattr = pthread_mutexattr_t()
        
        switch pthread_mutexattr_init(&mutexattr) {
        case ENOMEM:    throw InitError.outOfMemory
        default:        break
        }
        
        precondition(
            pthread_mutexattr_settype(&mutexattr,type.pthreadType) != EINVAL,
            "\(pthread_mutexattr_settype): Invalid value for attr, or invalid value for type."
        )
        
        switch pthread_mutex_init(_mutexPtr, &mutexattr) {
        case EAGAIN:    throw InitError.lackOfSystemResource
        case ENOMEM:    throw InitError.outOfMemory
        case EINVAL:    preconditionFailure("\(pthread_mutex_init): The value specified by attr is invalid.")
        default: break
        }
    }
    
    internal typealias InitError = MutexInitError
    
    internal var name: String
    
    private var _mutexPtr: UnsafeMutablePointer<pthread_mutex_t>
    
    deinit {
        pthread_mutex_destroy(_mutexPtr)
        _mutexPtr.deinitialize(count: 1)
        _mutexPtr.deallocate()
    }
    
    internal func tryToLock() -> Bool {
        switch pthread_mutex_trylock(_mutexPtr) {
        case EINVAL:
            preconditionFailure("\(self): The value specified by mutex is invalid.")
        case 0:
            return true
        default:
            return false
        }
    }
    
    internal func waitToLock() {
        var mutex_trylock_result = pthread_mutex_trylock(_mutexPtr)
        while mutex_trylock_result != 0 {
            precondition(
                mutex_trylock_result != EINVAL,
                "\(self): The value specified by mutex is invalid."
            )
            mutex_trylock_result = pthread_mutex_trylock(_mutexPtr)
        }
    }
    
    internal func unlock() {
        switch pthread_mutex_unlock(_mutexPtr) {
        case EINVAL:
            preconditionFailure("\(self): The value specified by mutex is invalid.")
        case EPERM:
            preconditionFailure("\(self): The current thread does not hold a lock on mutex.")
        default: break
        }
    }
}

internal enum MutexType: Int {
    case normal
    case errorCheck
    case recursive
    case `default`
    
    internal var pthreadType: Int32 {
        switch self {
        case .normal:       return PTHREAD_MUTEX_NORMAL
        case .errorCheck:   return PTHREAD_MUTEX_ERRORCHECK
        case .recursive:    return PTHREAD_MUTEX_RECURSIVE
        case .`default`:    return PTHREAD_MUTEX_DEFAULT
        }
    }
}

internal enum MutexInitError: Error {
    /// Caused by `pthread_mutexattr_t(:)` or `pthread_mutex_init(:)`'s
    /// `ENOMEM` error.
    case outOfMemory
    
    /// Caused by `pthread_mutex_init(::)`'s `EAGAIN` error. This is a
    /// temporary error, you can try it later.
    case lackOfSystemResource
}

extension MutexInitError: CustomStringConvertible {
    internal var description: String {
        switch self {
        case .lackOfSystemResource:
            return "The system temporarily lacks the resources to create another mutex."
        case .outOfMemory:
            return "The process cannot allocate enough memory to create another mutex."
        }
    }
}

//MARK: ReadWriteLock
public struct ReadWriteLockOptions: OptionSet {
    public typealias RawValue = UInt
    public var rawValue: RawValue
    public init(rawValue: RawValue) { self.rawValue = rawValue }
    
    public static let processShared = ReadWriteLockOptions(rawValue: 1 << 0)
}

public class ReadWriteLocked<L> {
    public typealias Locked = L
    
    private typealias Impl = ReadWriteLockedImpl<L>
    
    public init(
        _ locked: Locked,
        name: String,
        options: Options = []
        )
        throws
    {
        _impl = try Impl(
            locked: locked,
            name: name,
            options: options
        )
    }
    
    public init(
        _ locked: Locked,
        options: Options = []
        )
        throws
    {
        _impl = try Impl(
            locked: locked,
            name: "",
            options: options
        )
    }

	/// Wait to acquire a read/write lock for reading.
    public func withReadingAndWait<R>(
		closure: (Locked) throws -> R
        )
        rethrows
        -> R
    {
        _impl.waitToLockForReading()
        let returned = try closure(_impl.locked)
        _impl.unlock()
        return returned
    }
    
	/// Wait to acquire a read/write lock for writing.
    public func withWritingAndWait<R>(
		closure: (inout Locked) throws -> R
		)
        rethrows
        -> R
    {
        _impl.waitToLockForWriting()
        let returned = try closure(&_impl.locked)
        _impl.unlock()
        return returned
    }
	
	/// Try to acquire a read/write lock for reading.
    public func withReadingOrFail<R>(
		closure: (Locked) throws -> R
		)
        rethrows
        -> R?
    {
        if _impl.tryToLockForReading() {
            let returned = try closure(_impl.locked)
            _impl.unlock()
            return returned
        }
        return nil
    }
	
	/// Try to acquire a read/write lock for writing.
    public func withWritingOrFail<R>(
        closure: (inout Locked) throws -> R
        )
        rethrows
        -> R?
    {
        if _impl.tryToLockForWriting() {
            let returned = try closure(&_impl.locked)
            _impl.unlock()
            return returned
        }
        return nil
    }
	
	/// Try to acquire a read/write lock for reading.
    public func withReadingOrFail(
		closure: (Locked) throws -> Void
		)
        rethrows
        -> Bool
    {
        if _impl.tryToLockForReading() {
            try closure(_impl.locked)
            _impl.unlock()
            return true
        }
        return false
    }
	
	/// Try to acquire a read/write lock for writing.
    public func withWritingOrFail(
        closure: (inout Locked) throws -> Void
        )
        rethrows
        -> Bool
    {
        if _impl.tryToLockForWriting() {
            try closure(&_impl.locked)
            _impl.unlock()
            return true
        }
        return false
    }
    
    public typealias Options = ReadWriteLockOptions
    
    private let _impl: Impl
}


extension ReadWriteLocked: Equatable where L: Equatable {
    public static func == (lhs: ReadWriteLocked, rhs: ReadWriteLocked)
	    -> Bool
    {
	    return lhs.withReadingAndWait { (lhs) -> Bool in
		    rhs.withReadingAndWait { (rhs)  -> Bool in
			    return rhs == lhs
		    }
	    }
    }
}


public class ReadWriteLock {
    private typealias Impl = ReadWriteLockImpl
    
    public init(
        name: String,
        options: Options = []
        )
        throws
    {
        _impl = try Impl(
            name: name,
            options: options
        )
    }
    
    public init(
        options: Options = []
        )
        throws
    {
        _impl = try Impl(
            name: "",
            options: options
        )
    }
    
	/// Wait to acquire a read/write lock for reading.
    public func waitToAcquireReadingAndPerform<R>(
		closure: () throws -> R
		)
        rethrows
        -> R
    {
        _impl.waitToLockForReading()
        let returned = try closure()
        _impl.unlock()
        return returned
    }
    
	/// Wait to acquire a read/write lock for writing.
    public func waitToAcquireWritingAndPerform<R>(
		closure: () throws -> R
		)
        rethrows
        -> R
    {
        _impl.waitToLockForWriting()
        let returned = try closure()
        _impl.unlock()
        return returned
    }
    
	/// Try to acquire a read/write lock for reading.
    public func tryToAcquireReadingAndPerform<R>(
		closure: () throws -> R
		)
        rethrows
        -> R?
    {
        if _impl.tryToLockForReading() {
            let returned = try closure()
            _impl.unlock()
            return returned
        }
        return nil
    }
    
	/// Try to acquire a read/write lock for writing.
    public func tryToAcquireWritingAndPerform<R>(
		closure: () throws -> R
		)
        rethrows
        -> R?
    {
        if _impl.tryToLockForWriting() {
            let returned = try closure()
            _impl.unlock()
            return returned
        }
        return nil
    }
    
	/// Try to acquire a read/write lock for reading.
    public func tryToAcquireReadingAndPerform(
		closure: () throws -> Void
		)
        rethrows
        -> Bool
    {
        if _impl.tryToLockForReading() {
            try closure()
            _impl.unlock()
            return true
        }
        return false
    }
    
	/// Try to acquire a read/write lock for writing.
    public func tryToAcquireWritingAndPerform(
		closure: () throws -> Void
		)
        rethrows
        -> Bool
    {
        if _impl.tryToLockForWriting() {
            try closure()
            _impl.unlock()
            return true
        }
        return false
    }
    
    public typealias Options = ReadWriteLockOptions
    
    private let _impl: Impl
}



//MARK: Read Write Lock Implementation
internal class ReadWriteLockedImpl<L> {
    internal typealias Locked = L
    
    internal var locked: Locked
    
    internal init(locked: Locked, name: String = "", options: Options)
        throws
    {
        self.locked = locked
        self.name = name
        self.options = options
        
        _rwlockPtr = .allocate(capacity: 1)
        
        var rwlockxattr = pthread_rwlockattr_t()
        
        switch pthread_rwlockattr_init(&rwlockxattr) {
        case ENOMEM:    throw InitError.outOfMemory
        default:        break
        }
        
        if options.contains(.processShared) {
            precondition(
                pthread_rwlockattr_setpshared(&rwlockxattr, PTHREAD_PROCESS_SHARED) != EINVAL,
                "\(pthread_rwlockattr_setpshared): Invalid value for read/write lock's attributes, or invalid value for type."
            )
        } else {
            precondition(
                pthread_rwlockattr_setpshared(&rwlockxattr, PTHREAD_PROCESS_PRIVATE) != EINVAL,
                "\(pthread_rwlockattr_setpshared): Invalid value for read/write lock's attributes, or invalid value for type."
            )
        }
        
        switch pthread_rwlock_init(_rwlockPtr, &rwlockxattr) {
        case EAGAIN:    throw InitError.lackOfSystemResource
        case ENOMEM:    throw InitError.outOfMemory
        case EAGAIN:    throw InitError.lackOfSystemResource
        case EPERM:     throw InitError.noSufficientPrivilege
        case EBUSY:     throw InitError.doubleInitialization(_rwlockPtr)
        case EINVAL:    throw InitError.invalidAttributes(rwlockxattr)
        default: break
        }
    }
    
    internal typealias Options = ReadWriteLockOptions
    
    internal typealias InitError = ReadWriteLockInitError
    
    internal var name: String
    
    internal let options: Options
    
    private var _rwlockPtr: UnsafeMutablePointer<pthread_rwlock_t>
    
    deinit {
        pthread_rwlock_destroy(_rwlockPtr)
        _rwlockPtr.deinitialize(count: 1)
        _rwlockPtr.deallocate()
    }
    
    internal func tryToLockForReading() -> Bool {
        switch pthread_rwlock_tryrdlock(_rwlockPtr) {
        case EBUSY:
            return false
        case EAGAIN:
            return false
        case EDEADLK:
            return true
        case EINVAL:
            preconditionFailure("\(self): The value specified by rwlock(\(_rwlockPtr)) is invalid.")
        case ENOMEM:
            preconditionFailure("\(self): Insufficient memory exists to initialize the lock (applies to statically initialized locks only).")
        case 0:
            return true
        default:
            return false
        }
    }
    
    internal func waitToLockForReading() {
        while !tryToLockForReading() { }
    }
    
    internal func tryToLockForWriting() -> Bool {
        switch pthread_rwlock_trywrlock(_rwlockPtr) {
        case EBUSY:
            return false
        case EDEADLK:
            return true
        case EINVAL:
            preconditionFailure("\(self): The value specified by rwlock(\(_rwlockPtr)) is invalid.")
        case ENOMEM:
            preconditionFailure("\(self): Insufficient memory exists to initialize the lock (applies to statically initialized locks only).")
        case 0:
            return true
        default:
            return false
        }
    }
    
    internal func waitToLockForWriting() {
        while !tryToLockForWriting() { }
    }
    
    internal func unlock() {
        switch pthread_rwlock_unlock(_rwlockPtr) {
        case EINVAL:
            preconditionFailure("\(self): The value specified by mutex is invalid.")
        case EPERM:
            preconditionFailure("\(self): The current thread does not hold a lock on mutex.")
        default: break
        }
    }
}

internal class ReadWriteLockImpl {
    internal init(name: String = "", options: Options) throws {
        self.name = name
        self.options = options
        
        _rwlockPtr = .allocate(capacity: 1)
        
        var rwlockxattr = pthread_rwlockattr_t()
        
        switch pthread_rwlockattr_init(&rwlockxattr) {
        case ENOMEM:    throw InitError.outOfMemory
        default:        break
        }
        
        if options.contains(.processShared) {
            precondition(
                pthread_rwlockattr_setpshared(&rwlockxattr, PTHREAD_PROCESS_SHARED) != EINVAL,
                "\(pthread_rwlockattr_setpshared): Invalid value for read/write lock's attributes, or invalid value for type."
            )
        } else {
            precondition(
                pthread_rwlockattr_setpshared(&rwlockxattr, PTHREAD_PROCESS_PRIVATE) != EINVAL,
                "\(pthread_rwlockattr_setpshared): Invalid value for read/write lock's attributes, or invalid value for type."
            )
        }
        
        switch pthread_rwlock_init(_rwlockPtr, &rwlockxattr) {
        case EAGAIN:    throw InitError.lackOfSystemResource
        case ENOMEM:    throw InitError.outOfMemory
        case EAGAIN:    throw InitError.lackOfSystemResource
        case EPERM:     throw InitError.noSufficientPrivilege
        case EBUSY:     throw InitError.doubleInitialization(_rwlockPtr)
        case EINVAL:    throw InitError.invalidAttributes(rwlockxattr)
        default: break
        }
    }
    
    internal typealias Options = ReadWriteLockOptions
    
    internal typealias InitError = ReadWriteLockInitError
    
    internal var name: String
    
    internal let options: Options
    
    private var _rwlockPtr: UnsafeMutablePointer<pthread_rwlock_t>
    
    deinit {
        pthread_rwlock_destroy(_rwlockPtr)
        _rwlockPtr.deinitialize(count: 1)
        _rwlockPtr.deallocate()
    }
    
    internal func tryToLockForReading() -> Bool {
        switch pthread_rwlock_tryrdlock(_rwlockPtr) {
        case EBUSY:
            return false
        case EAGAIN:
            return false
        case EDEADLK:
            return true
        case EINVAL:
            preconditionFailure("\(self): The value specified by rwlock(\(_rwlockPtr)) is invalid.")
        case ENOMEM:
            preconditionFailure("\(self): Insufficient memory exists to initialize the lock (applies to statically initialized locks only).")
        case 0:
            return true
        default:
            return false
        }
    }
    
    internal func waitToLockForReading() {
        while !tryToLockForReading() { }
    }
    
    internal func tryToLockForWriting() -> Bool {
        switch pthread_rwlock_trywrlock(_rwlockPtr) {
        case EBUSY:
            return false
        case EDEADLK:
            return true
        case EINVAL:
            preconditionFailure("\(self): The value specified by rwlock(\(_rwlockPtr)) is invalid.")
        case ENOMEM:
            preconditionFailure("\(self): Insufficient memory exists to initialize the lock (applies to statically initialized locks only).")
        case 0:
            return true
        default:
            return false
        }
    }
    
    internal func waitToLockForWriting() {
        while !tryToLockForWriting() { }
    }
    
    internal func unlock() {
        switch pthread_rwlock_unlock(_rwlockPtr) {
        case EINVAL:
            preconditionFailure("\(self): The value specified by mutex is invalid.")
        case EPERM:
            preconditionFailure("\(self): The current thread does not hold a lock on mutex.")
        default: break
        }
    }
}

internal enum ReadWriteLockInitError: Error {
    case outOfMemory
    
    case lackOfSystemResource
    
    case noSufficientPrivilege
    
    case doubleInitialization(UnsafeMutablePointer<pthread_rwlock_t>)
    
    case invalidAttributes(pthread_rwlockattr_t)
}

extension ReadWriteLockInitError: CustomStringConvertible {
    internal var description: String {
        switch self {
        case .lackOfSystemResource:
            return "The system lacked the necessary resources (other than memory) to initialize the lock."
        case .outOfMemory:
            return "Insufficient memory exists to initialize the lock."
        case .noSufficientPrivilege:
            return "The caller does not have sufficient privilege to perform the operation."
        case let .doubleInitialization(ptr):
            return "The system has detected an attempt to re-initialize the object referenced by rwlock(\(ptr)), a previously initialized but not yet destroyed read/write lock."
        case let .invalidAttributes(attributes):
            return "The value specified by attr(\(attributes)) is invalid."
        }
    }
}
