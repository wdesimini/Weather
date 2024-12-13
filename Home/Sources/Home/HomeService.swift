//
//  HomeService.swift
//  Home
//
//  Created by Wilson Desimini on 12/12/24.
//

import Foundation
import Models
import Networking

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
        defaults.get(forKey: "selectedLocation")
    }

    public func saveSelectedLocation(_ location: LocationSearchResult?) async {
        if let location = location {
            defaults.set(location, forKey: "selectedLocation")
        } else {
            defaults.removeValue(forKey: "selectedLocation")
        }
    }

    public func searchCities(query: String) async throws -> [LocationSearchResult] {
        try await api.request(LocationSearchRequest(query: query))
    }

    public func fetchWeather(for location: LocationSearchResult) async throws -> CurrentWeather? {
        try await api.request(CurrentWeatherRequest(locationId: location.id))
    }
}
