//
//  LocationSearchResult.swift
//  Models
//
//  Created by Wilson Desimini on 12/12/24.
//

import Foundation

// sample data
// [{"id":2634070,"name":"Portland","region":"Oregon","country":"United States of America","lat":45.52,"lon":-122.68,"url":"portland-oregon-united-states-of-america"},{"id":2585165,"name":"Portland","region":"Maine","country":"United States of America","lat":43.66,"lon":-70.26,"url":"portland-maine-united-states-of-america"},{"id":2657787,"name":"Portland","region":"Texas","country":"United States of America","lat":27.88,"lon":-97.32,"url":"portland-texas-united-states-of-america"},{"id":2553581,"name":"Portland","region":"Connecticut","country":"United States of America","lat":41.57,"lon":-72.64,"url":"portland-connecticut-united-states-of-america"},{"id":135041,"name":"Portland","region":"Victoria","country":"Australia","lat":-38.33,"lon":141.6,"url":"portland-victoria-australia"}]

public struct LocationSearchResult: Codable {
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
