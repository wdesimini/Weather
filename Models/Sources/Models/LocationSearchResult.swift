//
//  LocationSearchResult.swift
//  Models
//
//  Created by Wilson Desimini on 12/12/24.
//

import Foundation

public struct LocationSearchResult: Codable, Sendable, Equatable, Identifiable {
    public let id: Int
    public let name: String
    public let region: String
    public let country: String
    public let lat: Double
    public let lon: Double
    public let url: String

    public init(id: Int, name: String, region: String, country: String, lat: Double, lon: Double, url: String) {
        self.id = id
        self.name = name
        self.region = region
        self.country = country
        self.lat = lat
        self.lon = lon
        self.url = url
    }
}
