//
//  CurrentWeatherDetailViewModel.swift
//  Home
//
//  Created by Wilson Desimini on 12/13/24.
//

import Foundation
import Models

struct CurrentWeatherDetailViewModel {
    let weather: CurrentWeather

    var nameText: String {
        weather.location.name
    }

    var iconURL: URL? {
        let iconURLString = "https:\(weather.current.condition.icon)"
        return URL(string: iconURLString.replacingOccurrences(of: "64x64", with: "128x128"))
    }

    var tempText: String {
        let temp = weather.current.tempF
        return "\(temp.formatted(.number.precision(.fractionLength(0))))°"
    }

    var humidityText: String {
        "\(weather.current.humidity)%"
    }

    var uvText: String {
        weather.current.uv.formatted(.number.precision(.fractionLength(0)))
    }

    var feelslikeText: String {
        "\(weather.current.feelslikeF.formatted(.number.precision(.fractionLength(0))))°"
    }
}
