//
//  CurrentWeatherRequest.swift
//  Home
//
//  Created by Wilson Desimini on 12/12/24.
//

import Foundation
import Models
import Networking

struct CurrentWeatherRequest: APIRequest {
    typealias Response = CurrentWeather

    let query: String

    init(locationId: LocationSearchResult.ID) {
        self.query = "id:\(locationId)"
    }

    var path: String {
        "v1/current.json"
    }

    var queryItems: [URLQueryItem]? {
        [.init(name: "q", value: query)]
    }
}
