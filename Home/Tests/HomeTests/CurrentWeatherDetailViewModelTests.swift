//
//  CurrentWeatherDetailViewModelTests.swift
//  Home
//
//  Created by Wilson Desimini on 12/13/24.
//

import XCTest
import Models
@testable import Home

final class CurrentWeatherDetailViewModelTests: XCTestCase {
    private let viewModel = CurrentWeatherDetailViewModel(weather: .mock)

    func test_nameText() {
        XCTAssertEqual(viewModel.nameText, "Portland")
    }

    func test_iconURL() {
        XCTAssertEqual(viewModel.iconURL, URL(string: "https://cdn.weatherapi.com/weather/128x128/night/296.png"))
    }

    func test_tempText() {
        XCTAssertEqual(viewModel.tempText, "40°")
    }

    func test_humidityText() {
        XCTAssertEqual(viewModel.humidityText, "83%")
    }

    func test_uvText() {
        XCTAssertEqual(viewModel.uvText, "0")
    }

    func test_feelslikeText() {
        XCTAssertEqual(viewModel.feelslikeText, "39°")
    }
}
