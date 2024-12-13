//
//  HomeService.swift
//  Home
//
//  Created by Wilson Desimini on 12/12/24.
//

import Foundation
import Models
import Networking

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
    func searchCities(query: String) async throws -> [LocationSearchResult]
    func fetchWeather(for location: String) async throws -> CurrentWeather?
}

public final class HomeService: HomeServiceProtocol {
    private let api: APIService

    public init(api: APIService = .init()) {
        self.api = api
    }

    public func loadSelectedLocation() async throws -> String? {
#warning("TODO: implement load selected location")
        return nil
    }

    public func searchCities(query: String) async throws -> [LocationSearchResult] {
        try await api.request(LocationSearchRequest(query: query))
    }

    public func fetchWeather(for location: String) async throws -> CurrentWeather? {
#warning("TODO: implement weather fetch")
        return nil
    }
}
