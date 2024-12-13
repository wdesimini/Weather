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
    func loadSelectedLocation() async throws -> LocationSearchResult?
    func saveSelectedLocation(_ location: LocationSearchResult?) async
    func searchCities(query: String) async throws -> [LocationSearchResult]
    func fetchWeather(for location: LocationSearchResult) async throws -> CurrentWeather?
}

public final class HomeService: HomeServiceProtocol {
    private let api: APIService
    private let defaults: DefaultsServiceProtocol

    public init(
        api: APIService = .init(),
        defaults: DefaultsServiceProtocol = DefaultsService()
    ) {
        self.api = api
        self.defaults = defaults
    }

    public func loadSelectedLocation() async throws -> LocationSearchResult? {
        defaults.get(LocationSearchResult.self, forKey: "selectedLocation")
    }

    public func saveSelectedLocation(_ location: LocationSearchResult?) async {
        defaults.set(location, forKey: "selectedLocation")
    }

    public func searchCities(query: String) async throws -> [LocationSearchResult] {
        try await api.request(LocationSearchRequest(query: query))
    }

    public func fetchWeather(for location: LocationSearchResult) async throws -> CurrentWeather? {
#warning("TODO: implement weather fetch")
        return nil
    }
}
