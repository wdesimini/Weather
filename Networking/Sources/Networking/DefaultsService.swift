//
//  DefaultsService.swift
//  Networking
//
//  Created by Wilson Desimini on 12/12/24.
//

import Foundation

public protocol DefaultsServiceProtocol: Sendable {
    func set<T>(_ value: T, forKey key: String)
    func get<T>(_ type: T.Type, forKey key: String) -> T?
    func removeValue(forKey key: String)
}

public final class DefaultsService: DefaultsServiceProtocol {
    private var defaults: UserDefaults {
        UserDefaults.standard
    }

    public init() {
    }

    public func set<T>(_ value: T, forKey key: String) {
        defaults.set(value, forKey: key)
    }

    public func get<T>(_ type: T.Type, forKey key: String) -> T? {
        defaults.object(forKey: key) as? T
    }

    public func removeValue(forKey key: String) {
        defaults.removeObject(forKey: key)
    }
}
