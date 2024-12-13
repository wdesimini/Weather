//
//  HomeViewModel.swift
//  Home
//
//  Created by Wilson Desimini on 12/12/24.
//

import Foundation
import Models

@MainActor
@Observable
public final class HomeViewModel {
    private let service: HomeServiceProtocol
    private(set) var loading = false
    private(set) var searchResults = [LocationSearchResult]()
    private(set) var location: LocationSearchResult?
    private(set) var weather: CurrentWeather?
    private(set) var error: Error?

    public init(service: HomeServiceProtocol = HomeService()) {
        self.service = service
    }

    func onAppear() async {
        await loadSelectedLocation()
        guard let location else { return }
        await fetchWeather(for: location)
    }

    func search(for query: String) async {
        loading = true
        do {
            await selectLocation(nil)
            searchResults = try await service.searchCities(query: query)
        } catch {
            handleError(error)
        }
        loading = false
    }

    func loadSelectedLocation() async {
        loading = true
        do {
            location = try await service.loadSelectedLocation()
        } catch {
            handleError(error)
        }
        loading = false
    }

    func selectLocation(_ location: LocationSearchResult?) async {
        self.weather = nil
        self.location = location
        await service.saveSelectedLocation(location)
        guard let location else { return }
        await fetchWeather(for: location)
    }

    func fetchWeather(for location: LocationSearchResult) async {
        loading = true
        do {
            weather = try await service.fetchWeather(for: location)
        } catch {
            handleError(error)
        }
        loading = false
    }

    func handleError(_ error: Error?) {
        self.error = error
    }
}
