//
//  APIErrorResponse.swift
//  Networking
//
//  Created by Wilson Desimini on 12/13/24.
//

import Foundation

public struct APIErrorResponse: Codable, Sendable {
    public struct ErrorInfo: Codable, Sendable {
        public let code: Int
        public let message: String

        public init(code: Int, message: String) {
            self.code = code
            self.message = message
        }
    }

    public let error: ErrorInfo

    public init(error: ErrorInfo) {
        self.error = error
    }
}
