//
//  APIRequest.swift
//  Networking
//
//  Created by Wilson Desimini on 12/12/24.
//

import Foundation

public protocol APIRequest {
    associatedtype Response: Decodable, Sendable
    var path: String { get }
    var queryItems: [URLQueryItem]? { get }
}

public extension APIRequest {
    var queryItems: [URLQueryItem]? { nil }
}
