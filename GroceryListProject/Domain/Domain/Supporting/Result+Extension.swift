//
//  Result+Extension.swift
//  Domain
//
//  Created by Jezreel Barbosa on 11/02/21.
//

public typealias ResultCompletion<T> = (_ result: Swift.Result<T, Error>) -> Void

public extension Swift.Result {

    var success: Success? {
        switch self {
        case let .success(value):
            return value
        case .failure:
            return nil
        }
    }

    var failure: Failure? {
        switch self {
        case .success:
            return nil
        case let .failure(error):
            return error
        }
    }

    var isSuccess: Bool {
        switch self {
        case .success: return true
        case .failure: return false
        }
    }

    var isFailure: Bool {
        switch self {
        case .success: return false
        case .failure: return true
        }
    }

    @discardableResult func successHandler(_ handler: (Success) -> Void) -> Self {
        if case let .success(value) = self {
            handler(value)
        }
        return self
    }

    @discardableResult func failureHandler(_ handler: (Failure) -> Void) -> Self {
        if case let .failure(error) = self {
            handler(error)
        }
        return self
    }
}
