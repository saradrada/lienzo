//
//  ExportService.swift
//  SpeakArt
//
//  Created by Sara Ortiz Drada on 12.08.24.
//

import Foundation

import Foundation

protocol ExportServiceProtocol {
    func createExport(designID: String, format: String) async throws -> String
}

import Foundation

//class ExportService: ExportServiceProtocol {
//    private let baseURL = "https://canva.yesidlopez.de"
//
//    func createExport(designID: String, format: String) async throws -> String {
//        guard var urlComponents = URLComponents(string: "\(baseURL)/export/create") else {
//            throw URLError(.badURL)
//        }
//
//        // Add query parameters
//        urlComponents.queryItems = [
//            URLQueryItem(name: "design_id", value: designID),
//            URLQueryItem(name: "format", value: format)
//        ]
//
//        guard let url = urlComponents.url else {
//            throw URLError(.badURL)
//        }
//
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.setValue("application/json", forHTTPHeaderField: "Accept")
//
//        let (data, response) = try await URLSession.shared.data(for: request)
//
//        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
//            throw URLError(.badServerResponse)
//        }
//
//        guard let exportResponse = String(data: data, encoding: .utf8) else {
//            throw URLError(.cannotParseResponse)
//        }
//
//        return exportResponse
//    }
//}

class ExportService: ExportServiceProtocol {
    private let baseURL = "http://192.168.2.199"

    func createExport(designID: String, format: String) async throws -> String {
        guard var urlComponents = URLComponents(string: "\(baseURL)/export/create") else {
            throw URLError(.badURL)
        }

        // Add query parameters
        urlComponents.queryItems = [
            URLQueryItem(name: "design_id", value: designID),
            URLQueryItem(name: "format", value: format)
        ]

        guard let url = urlComponents.url else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Accept")

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }

        let exportResponse = try JSONDecoder().decode(ExportResponse.self, from: data)

        // Return the first URL from the "urls" array
        guard let firstURL = exportResponse.urls.first else {
            throw URLError(.cannotParseResponse)
        }

        return firstURL
    }
}
