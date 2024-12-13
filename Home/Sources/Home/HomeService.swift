//
//  HomeService.swift
//  Home
//
//  Created by Wilson Desimini on 12/12/24.
//

import Foundation

enum HomeServiceError: LocalizedError {
    case weatherRequestError

    var errorDescription: String? {
        switch self {
        case .weatherRequestError:
            "Error fetching weather"
        }
    }
}

public protocol HomeServiceProtocol: Sendable {
    func loadSelectedLocation() async throws -> String?
    func searchCities(query: String) async throws -> [String]
    func fetchWeather(for location: String) async throws -> String?
}

public final class HomeService: HomeServiceProtocol {
    public init() {
    }

    public func loadSelectedLocation() async throws -> String? {
#warning("TODO: implement load selected location")
        return nil
    }

    public func searchCities(query: String) async throws -> [String] {
#warning("TODO: implement search")
        return ["\(query)", "\(query) again"]
    }

    public func fetchWeather(for location: String) async throws -> String? {
#warning("TODO: implement weather fetch")
        return nil
    }
}
