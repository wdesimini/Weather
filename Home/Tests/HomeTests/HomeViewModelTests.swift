//
//  HomeViewModelTests.swift
//  Home
//
//  Created by Wilson Desimini on 12/12/24.
//

import XCTest
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
        service.selectedLocation = "Portland, OR"
        // and weather request for location succeeds
        service.fetchWeatherResults["Portland, OR"] = .success("Sunny")
        // when when view appears
        await viewModel.onAppear()
        // then home should have selected location
        XCTAssertEqual(viewModel.location, "Portland, OR")
        // and home should have weather
        XCTAssertEqual(viewModel.weather, "Sunny")
        // and home should not have error
        XCTAssertNil(viewModel.error)
    }

    func test_onAppear_savedLocationFailedWeatherRequest_error() async {
        let (service, viewModel) = configure()
        // given location saved
        service.selectedLocation = "Portland, OR"
        // and weather request for location fails
        service.fetchWeatherResults["Portland, OR"] = .failure(.weatherRequestError)
        // when when view appears
        await viewModel.onAppear()
        // then home should have selected location
        XCTAssertEqual(viewModel.location, "Portland, OR")
        // and home should not have weather
        XCTAssertNil(viewModel.weather)
        // and home should show weather request error
        XCTAssertEqual(viewModel.error as? HomeServiceError, .weatherRequestError)
    }
}

// MARK: - Mocks

private final class MockHomeService: HomeServiceProtocol, @unchecked Sendable {
    var selectedLocation: String?
    var searchCitiesResults = [String: Result<[String], HomeServiceError>]()
    var fetchWeatherResults = [String: Result<String?, HomeServiceError>]()

    func loadSelectedLocation() async throws -> String? {
        selectedLocation
    }

    func searchCities(query: String) async throws -> [String] {
        try searchCitiesResults[query]!.get()
    }

    func fetchWeather(for location: String) async throws -> String? {
        try fetchWeatherResults[location]!.get()
    }
}
