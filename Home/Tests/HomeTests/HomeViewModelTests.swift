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
        service.selectedLocation = "Portland, OR"
        // and weather request for location succeeds
        service.fetchWeatherResults["Portland, OR"] = .success(.mock)
        // when when view appears
        await viewModel.onAppear()
        // then home should have selected location
        XCTAssertEqual(viewModel.location, "Portland, OR")
        // and home should have weather
        XCTAssertEqual(viewModel.weather, .mock)
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
}

// MARK: - Mocks

private final class MockHomeService: HomeServiceProtocol, @unchecked Sendable {
    var selectedLocation: String?
    var searchCitiesResults = [String: Result< [LocationSearchResult], HomeServiceError>]()
    var fetchWeatherResults = [String: Result<CurrentWeather?, HomeServiceError>]()

    func loadSelectedLocation() async throws -> String? {
        selectedLocation
    }

    func searchCities(query: String) async throws ->  [LocationSearchResult] {
        try searchCitiesResults[query]!.get()
    }

    func fetchWeather(for location: String) async throws -> CurrentWeather? {
        try fetchWeatherResults[location]!.get()
    }
}

private struct MockDataGenerator {
    static func mock<T: Decodable>(from raw: String) -> T {
        let data = raw.data(using: .utf8)!
        return try! JSONDecoder.apiDecoder.decode(T.self, from: data)
    }
}

extension Array where Element == LocationSearchResult {
    static var mock: Self {
        MockDataGenerator.mock(from: #"[{"id":2634070,"name":"Portland","region":"Oregon","country":"United States of America","lat":45.52,"lon":-122.68,"url":"portland-oregon-united-states-of-america"},{"id":2585165,"name":"Portland","region":"Maine","country":"United States of America","lat":43.66,"lon":-70.26,"url":"portland-maine-united-states-of-america"},{"id":2657787,"name":"Portland","region":"Texas","country":"United States of America","lat":27.88,"lon":-97.32,"url":"portland-texas-united-states-of-america"},{"id":2553581,"name":"Portland","region":"Connecticut","country":"United States of America","lat":41.57,"lon":-72.64,"url":"portland-connecticut-united-states-of-america"},{"id":135041,"name":"Portland","region":"Victoria","country":"Australia","lat":-38.33,"lon":141.6,"url":"portland-victoria-australia"}]"#)
    }
}

extension CurrentWeather {
    static var mock: CurrentWeather {
        MockDataGenerator.mock(from: #"{"location":{"name":"Portland","region":"Oregon","country":"United States of America","lat":45.5236,"lon":-122.675,"tz_id":"America/Los_Angeles","localtime_epoch":1734052976,"localtime":"2024-12-12 17:22"},"current":{"last_updated_epoch":1734052500,"last_updated":"2024-12-12 17:15","temp_c":4.4,"temp_f":39.9,"is_day":0,"condition":{"text":"Light rain","icon":"//cdn.weatherapi.com/weather/64x64/night/296.png","code":1183},"wind_mph":2.2,"wind_kph":3.6,"wind_degree":64,"wind_dir":"ENE","pressure_mb":1012.0,"pressure_in":29.88,"precip_mm":0.0,"precip_in":0.0,"humidity":83,"cloud":100,"feelslike_c":4.0,"feelslike_f":39.3,"windchill_c":3.4,"windchill_f":38.1,"heatindex_c":4.7,"heatindex_f":40.4,"dewpoint_c":2.7,"dewpoint_f":36.9,"vis_km":16.0,"vis_miles":9.0,"uv":0.0,"gust_mph":2.7,"gust_kph":4.3}}"#)
    }
}
