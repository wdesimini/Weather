//
//  APIError.swift
//  Networking
//
//  Created by Wilson Desimini on 12/12/24.
//

import Foundation

public enum APIError: LocalizedError {
    case apiError(APIErrorResponse.ErrorInfo)
    case invalidResponse
    case invalidURL
    case networkError(Error)
    case decodingError(Error)

    public var errorDescription: String? {
        switch self {
        case .apiError(let errorInfo):
            "\(errorInfo.code): \(errorInfo.message)"
        case .invalidResponse:
            "Invalid Response"
        case .invalidURL:
            "Invalid URL"
        case .networkError(let error):
            "Network Error: \(error.localizedDescription)"
        case .decodingError(let error):
            "Decoding Error: \(error.localizedDescription)"
        }
    }
}
