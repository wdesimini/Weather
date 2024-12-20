//
//  APIService.swift
//  Networking
//
//  Created by Wilson Desimini on 12/12/24.
//

import Foundation
import os.log

public protocol APIServiceProtocol: Actor {
    func request<T: APIRequest>(_ request: T) async throws -> T.Response
}

public actor APIService: APIServiceProtocol {
    private let baseURL: URL
    private let key: String
    private let decoder: JSONDecoder
    private let logger = Logger(subsystem: "com.Weather.Networking", category: "APIService")
    private let session: URLSession

    public init(
        baseURL: URL = URL(string: "https://api.weatherapi.com")!,
        key: String = APIEnvironment.key,
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
        components?.queryItems = request.queryItems.map { $0 + [.init(name: "key", value: key)] }
        guard let finalURL = components?.url else { throw APIError.invalidURL }
        logger.debug("Requesting \(finalURL)")
        let (data, _): (Data, URLResponse)
        do {
            (data, _) = try await session.data(from: finalURL)
        } catch {
            throw APIError.networkError(error)
        }
        do {
            logger.debug("Decoding data: \(String(data: data, encoding: .utf8) ?? "")")
            return try decoder.decode(T.Response.self, from: data)
        } catch {
#warning("TODO: server error info can come back as data packet")
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
