//
//  HomeViewModelTests.swift
//  Home
//
//  Created by Wilson Desimini on 12/12/24.
//

import XCTest
import Models
@testable import Home

@MainActor
final class HomeViewModelTests: XCTestCase {
    private func configure() -> (MockHomeService, HomeViewModel) {
        let service = MockHomeService()
        let viewModel = HomeViewModel(service: service)
        return (service, viewModel)
    }

    override func setUp() {
        continueAfterFailure = false
    }

    func test_onAppear_noSavedLocation_empty() async {
        let (service, viewModel) = configure()
        // given no location saved
        service.selectedLocation = nil
        // when view appears
        await viewModel.onAppear()
        // then home should show empty state
        XCTAssertNil(viewModel.location)
    }

    func test_onAppear_savedLocationWeatherRequest_success() async {
        let (service, viewModel) = configure()
        // given location saved
        service.selectedLocation = .mock
        // and weather request for location succeeds
        service.fetchWeatherResults[2634070] = .success(.mock)
        // when when view appears
        await viewModel.onAppear()
        // then home should have selected location
        XCTAssertEqual(viewModel.location, .mock)
        // and home should have weather
        XCTAssertEqual(viewModel.weather, .mock)
        // and home should not have error
        XCTAssertNil(viewModel.error)
    }

    func test_onAppear_savedLocationFailedWeatherRequest_error() async {
        let (service, viewModel) = configure()
        // given location saved
        service.selectedLocation = .mock
        // and weather request for location fails
        service.fetchWeatherResults[2634070] = .failure(.weatherRequestError)
        // when when view appears
        await viewModel.onAppear()
        // then home should have selected location
        XCTAssertEqual(viewModel.location, .mock)
        // and home should not have weather
        XCTAssertNil(viewModel.weather)
        // and home should show weather request error
        XCTAssertEqual(viewModel.error as? MockHomeServiceError, .weatherRequestError)
    }

    func test_search_locationSelected_selectionWeatherCleared() async {
        let (service, viewModel) = configure()
        // given location selected and weather loaded
        service.fetchWeatherResults[2634070] = .success(.mock)
        await viewModel.selectLocation(LocationSearchResult.mock)
        XCTAssertEqual(service.selectedLocation, .mock)
        XCTAssertEqual(viewModel.location, .mock)
        XCTAssertEqual(viewModel.weather, .mock)
        // when some search is performed
        await viewModel.search(for: "Portland")
        // then selection cleared from view model
        XCTAssertNil(viewModel.location)
        // and weather cleared from view model
        XCTAssertNil(viewModel.weather)
        // and selection cleared from service
        XCTAssertNil(service.selectedLocation)
    }

    func test_search_searchSuccessful_searchResults() async {
        let (service, viewModel) = configure()
        // given city search query
        let query = "Portland"
        // and search succeeds
        service.searchCitiesResults[query] = .success(.mock)
        // when search is performed
        await viewModel.search(for: query)
        // then search results should be set
        XCTAssertEqual(viewModel.searchResults, .mock)
    }

    func test_selectLocation_locationSelectedSuccessfulWeatherRequest_locationSavedWeatherFetched() async {
        let (service, viewModel) = configure()
        // given a location
        let location = LocationSearchResult.mock
        // and the location weather
        service.fetchWeatherResults[location.id] = .success(.mock)
        // when location is selected
        await viewModel.selectLocation(location)
        // then location is selected
        XCTAssertEqual(viewModel.location, location)
        // and location is saved
        XCTAssertEqual(service.selectedLocation, location)
        // and weather is fetched
        XCTAssertEqual(viewModel.weather, .mock)
    }

    func test_selectLocation_locationSelectedFailedWeatherRequest_locationSavedRequestError() async {
        let (service, viewModel) = configure()
        // given a location
        let location = LocationSearchResult.mock
        // and the location weather request fails
        service.fetchWeatherResults[location.id] = .failure(.weatherRequestError)
        // when location is selected
        await viewModel.selectLocation(location)
        // then location is selected
        XCTAssertEqual(viewModel.location, location)
        // and location is saved
        XCTAssertEqual(service.selectedLocation, location)
        // and error is set
        XCTAssertEqual(viewModel.error as? MockHomeServiceError, .weatherRequestError)
    }
}

// MARK: - Mocks

private enum MockHomeServiceError: Error {
    case weatherRequestError
}

private final class MockHomeService: HomeServiceProtocol, @unchecked Sendable {
    var selectedLocation: LocationSearchResult?
    var searchCitiesResults = [String: Result<[LocationSearchResult], MockHomeServiceError>]()
    var fetchWeatherResults = [LocationSearchResult.ID: Result<CurrentWeather?, MockHomeServiceError>]()

    func loadSelectedLocation() async throws -> LocationSearchResult? {
        selectedLocation
    }

    func saveSelectedLocation(_ location: LocationSearchResult?) async {
        selectedLocation = location
    }

    func searchCities(query: String) async throws ->  [LocationSearchResult] {
        try searchCitiesResults[query]?.get() ?? []
    }

    func fetchWeather(for location: LocationSearchResult) async throws -> CurrentWeather? {
        try fetchWeatherResults[location.id]?.get()
    }
}
