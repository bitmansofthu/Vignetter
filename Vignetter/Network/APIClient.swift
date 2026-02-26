//
//  APIClient.swift
//  Vignetter
//
//  Created by Ferenc Knebl on 2026. 02. 18..
//

import FactoryKit
import Foundation
import OSLog

enum APIClientError: Error, LocalizedError {
    case invalidURL
    case invalidResponse
    case httpStatusCode(Int)
    case decodingError(Error)
    case encodingError(Error)
    case unknown(Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL: return "The URL provided was invalid."
        case .invalidResponse: return "The server returned an invalid response."
        case .httpStatusCode(let code): return "The server returned an error code: \(code)."
        case .decodingError(let error): return "Failed to decode data: \(error.localizedDescription)"
        case .encodingError(let error): return "Failed to encode data: \(error.localizedDescription)"
        case .unknown(let error): return "An unknown error occurred: \(error.localizedDescription)"
        }
    }
}

enum APIClientRequestType {
    case get
    case post(any Encodable)
    
    var value: String {
        switch self {
        case .get:
            return "GET"
        case .post:
            return "POST"
        }
    }
}

protocol APIClientProtocol {
    func request<Response: Decodable>(type: APIClientRequestType, endpoint: String) async throws -> Response
}

struct APIClient: APIClientProtocol {
    
    @Injected(\.appConfig) var appConfig
    private let session: URLSession
    private let encoder: JSONEncoder
    private let decoder: JSONDecoder

    init(
        session: URLSession = .shared,
        encoder: JSONEncoder = JSONEncoder(),
        decoder: JSONDecoder = JSONDecoder()
    ) {
        self.session = session
        self.encoder = encoder
        self.decoder = decoder
    }
    
    func request<Response>(type: APIClientRequestType, endpoint: String) async throws -> Response where Response : Decodable {
        guard let url = URL(string: "\(appConfig.baseUrl)\(endpoint)") else {
            throw APIClientError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = type.value
        
        Logger.network.info("⬆️ Sending request to url: \(url.absoluteString)")

        if case let .post(payload) = type {
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            do {
                let data = try encoder.encode(payload)
                #if DEBUG
                Logger.logJSON(data, prefix: "POST JSON")
                #endif
                request.httpBody = data
            } catch {
                throw APIClientError.encodingError(error)
            }
        }
        
        let (data, response) = try await session.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIClientError.invalidResponse
        }

        guard (200...299).contains(httpResponse.statusCode) else {
            throw APIClientError.httpStatusCode(httpResponse.statusCode)
        }

        do {
            #if DEBUG
            Logger.logJSON(data, prefix: "⬇️ Response JSON")
            #endif
            return try decoder.decode(Response.self, from: data)
        } catch {
            throw APIClientError.decodingError(error)
        }
    }
}

fileprivate extension Logger {
    private static var subsystem = Bundle.main.bundleIdentifier!
    static let network = Logger(subsystem: subsystem, category: "Network")

    static func logJSON(_ data: Data, prefix: String = "Payload") {
        if let object = try? JSONSerialization.jsonObject(with: data, options: []),
           let prettyData = try? JSONSerialization.data(withJSONObject: object, options: .prettyPrinted),
           let prettyString = String(data: prettyData, encoding: .utf8) {
            network.debug("\(prefix):\n\(prettyString)")
        } else if let fallbackString = String(data: data, encoding: .utf8) {
            network.error("Failed to format JSON for \(prefix). Raw content:\n\(fallbackString)")
        }
    }
}
