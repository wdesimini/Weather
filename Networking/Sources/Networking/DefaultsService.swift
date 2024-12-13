//
//  DefaultsService.swift
//  Networking
//
//  Created by Wilson Desimini on 12/12/24.
//

import Foundation

public protocol DefaultsServiceProtocol: Sendable {
    func set<T: Codable>(_ value: T, forKey key: String)
    func get<T: Codable>(forKey key: String) -> T?
    func removeValue(forKey key: String)
}

public final class DefaultsService: DefaultsServiceProtocol {
    private let encoder: JSONEncoder
    private let decoder: JSONDecoder

    public init(
        encoder: JSONEncoder = .init(),
        decoder: JSONDecoder = .apiDecoder
    ) {
        self.encoder = encoder
        self.decoder = decoder
    }

    private var defaults: UserDefaults {
        UserDefaults.standard
    }

    public func set<T>(_ value: T, forKey key: String) where T : Decodable, T : Encodable {
        guard let data = try? encoder.encode(value) else { return }
        defaults.set(data, forKey: key)
    }

    public func get<T>(forKey key: String) -> T? where T : Decodable, T : Encodable {
        guard let data = defaults.data(forKey: key) else { return nil }
        return try? decoder.decode(T.self, from: data)
    }

    public func removeValue(forKey key: String) {
        defaults.removeObject(forKey: key)
    }
}
