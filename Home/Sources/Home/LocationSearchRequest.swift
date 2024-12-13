//
//  LocationSearchRequest.swift
//  Home
//
//  Created by Wilson Desimini on 12/12/24.
//

import Foundation
import Models
import Networking

struct LocationSearchRequest: APIRequest {
    typealias Response = [LocationSearchResult]

    let query: String

    init(query: String) {
        self.query = query
    }

    var path: String {
        "v1/search.json"
    }

    var queryItems: [URLQueryItem]? {
        [.init(name: "q", value: query)]
    }
}
