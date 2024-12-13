//
//  Weather.swift
//  Models
//
//  Created by Wilson Desimini on 12/12/24.
//

import Foundation

// sample data
// {"location":{"name":"Portland","region":"Oregon","country":"United States of America","lat":45.5236,"lon":-122.675,"tz_id":"America/Los_Angeles","localtime_epoch":1734052976,"localtime":"2024-12-12 17:22"},"current":{"last_updated_epoch":1734052500,"last_updated":"2024-12-12 17:15","temp_c":4.4,"temp_f":39.9,"is_day":0,"condition":{"text":"Light rain","icon":"//cdn.weatherapi.com/weather/64x64/night/296.png","code":1183},"wind_mph":2.2,"wind_kph":3.6,"wind_degree":64,"wind_dir":"ENE","pressure_mb":1012.0,"pressure_in":29.88,"precip_mm":0.0,"precip_in":0.0,"humidity":83,"cloud":100,"feelslike_c":4.0,"feelslike_f":39.3,"windchill_c":3.4,"windchill_f":38.1,"heatindex_c":4.7,"heatindex_f":40.4,"dewpoint_c":2.7,"dewpoint_f":36.9,"vis_km":16.0,"vis_miles":9.0,"uv":0.0,"gust_mph":2.7,"gust_kph":4.3}}

public struct CurrentLocationWeather: Codable {
    public struct Weather: Codable {
        public struct Condition: Codable {
            public let text: String
            public let icon: String
            public let code: Int

            public init(text: String, icon: String, code: Int) {
                self.text = text
                self.icon = icon
                self.code = code
            }
        }

        public let lastUpdatedEpoch: Int
        public let lastUpdated: String
        public let tempC: Double
        public let tempF: Double
        public let isDay: Int
        public let condition: Condition
        public let windMph: Double
        public let windKph: Double
        public let windDegree: Int
        public let windDir: String
        public let pressureMb: Int
        public let pressureIn: Double
        public let precipMm: Int
        public let precipIn: Int
        public let humidity: Int
        public let cloud: Int
        public let feelslikeC: Int
        public let feelslikeF: Double
        public let windchillC: Double
        public let windchillF: Double
        public let heatindexC: Double
        public let heatindexF: Double
        public let dewpointC: Double
        public let dewpointF: Double
        public let visKm: Int
        public let visMiles: Int
        public let uv: Int
        public let gustMph: Double
        public let gustKph: Double

        public init(lastUpdatedEpoch: Int, lastUpdated: String, tempC: Double, tempF: Double, isDay: Int, condition: Condition, windMph: Double, windKph: Double, windDegree: Int, windDir: String, pressureMb: Int, pressureIn: Double, precipMm: Int, precipIn: Int, humidity: Int, cloud: Int, feelslikeC: Int, feelslikeF: Double, windchillC: Double, windchillF: Double, heatindexC: Double, heatindexF: Double, dewpointC: Double, dewpointF: Double, visKm: Int, visMiles: Int, uv: Int, gustMph: Double, gustKph: Double) {
            self.lastUpdatedEpoch = lastUpdatedEpoch
            self.lastUpdated = lastUpdated
            self.tempC = tempC
            self.tempF = tempF
            self.isDay = isDay
            self.condition = condition
            self.windMph = windMph
            self.windKph = windKph
            self.windDegree = windDegree
            self.windDir = windDir
            self.pressureMb = pressureMb
            self.pressureIn = pressureIn
            self.precipMm = precipMm
            self.precipIn = precipIn
            self.humidity = humidity
            self.cloud = cloud
            self.feelslikeC = feelslikeC
            self.feelslikeF = feelslikeF
            self.windchillC = windchillC
            self.windchillF = windchillF
            self.heatindexC = heatindexC
            self.heatindexF = heatindexF
            self.dewpointC = dewpointC
            self.dewpointF = dewpointF
            self.visKm = visKm
            self.visMiles = visMiles
            self.uv = uv
            self.gustMph = gustMph
            self.gustKph = gustKph
        }
    }

    public struct Location: Codable {
        public let name: String
        public let region: String
        public let country: String
        public let lat: Double
        public let lon: Double
        public let tzId: String
        public let localtimeEpoch: Int
        public let localtime: String

        public init(name: String, region: String, country: String, lat: Double, lon: Double, tzId: String, localtimeEpoch: Int, localtime: String) {
            self.name = name
            self.region = region
            self.country = country
            self.lat = lat
            self.lon = lon
            self.tzId = tzId
            self.localtimeEpoch = localtimeEpoch
            self.localtime = localtime
        }
    }

    public let location: Location
    public let current: Weather

    public init(location: Location, current: Weather) {
        self.location = location
        self.current = current
    }
}
