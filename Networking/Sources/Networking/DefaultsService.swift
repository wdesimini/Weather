//
//  DefaultsService.swift
//  Networking
//
//  Created by Wilson Desimini on 12/12/24.
//

import Foundation

public enum DefaultsKey: String {
    case selectedLocation
}

public protocol DefaultsServiceProtocol: Actor {
    func set<T: Codable>(_ value: T, forKey key: DefaultsKey)
    func get<T: Codable>(forKey key: DefaultsKey) -> T?
    func removeValue(forKey key: DefaultsKey)
}

public actor DefaultsService: DefaultsServiceProtocol {
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

    public func set<T>(_ value: T, forKey key: DefaultsKey) where T : Decodable, T : Encodable {
        guard let data = try? encoder.encode(value) else { return }
        defaults.set(data, forKey: key.rawValue)
    }

    public func get<T>(forKey key: DefaultsKey) -> T? where T : Decodable, T : Encodable {
        guard let data = defaults.data(forKey: key.rawValue) else { return nil }
        return try? decoder.decode(T.self, from: data)
    }

    public func removeValue(forKey key: DefaultsKey) {
        defaults.removeObject(forKey: key.rawValue)
    }
}
