//
//  APIService.swift
//  Networking
//
//  Created by Wilson Desimini on 12/12/24.
//

import Foundation
import os.log

public actor APIService {
    private let baseURL: URL
    private let key: String
    private let decoder: JSONDecoder
    private let logger = Logger(subsystem: "com.Weather.Networking", category: "APIService")
    private let session: URLSession

    public init(
        baseURL: URL = URL(string: "api.weatherapi.com")!,
        key: String = "",
        decoder: JSONDecoder = .apiDecoder,
        session: URLSession = .shared
    ) {
        self.baseURL = baseURL
        self.key = key
        self.decoder = decoder
        self.session = session
    }

    public func request<T: APIRequest>(_ request: T) async throws -> T.Response {
        let url = baseURL.appendingPathComponent(request.path)
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        components?.queryItems = request.queryItems
        guard let finalURL = components?.url else { throw APIError.invalidURL }
        logger.debug("Requesting \(finalURL)")
        let (data, _): (Data, URLResponse)
        do {
            (data, _) = try await session.data(from: finalURL)
        } catch {
            throw APIError.networkError(error)
        }
        do {
            logger.debug("Decoding data (len: \(data.count), type: \(T.Response.self))")
            return try decoder.decode(T.Response.self, from: data)
        } catch {
            throw APIError.decodingError(error)
        }
    }
}

extension JSONDecoder {
    public static var apiDecoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }
}
