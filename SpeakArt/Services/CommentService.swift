//
//  CommentService.swift
//  SpeakArt
//
//  Created by Sara Ortiz Drada on 12.08.24.
//

import Foundation

protocol CommentServiceProtocol {
    func createComment(designID: String, message: String) async throws -> String
}

import Foundation

class CommentService: CommentServiceProtocol {
    private let baseURL = "https://canva.yesidlopez.de"
//    private let baseURL = "http://192.168.2.199:80"

    func createComment(designID: String, message: String) async throws -> String {
        guard let url = URL(string: "\(baseURL)/comments") else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let requestBody: [String: String] = ["design_id": designID, "message": message]
        request.httpBody = try JSONSerialization.data(withJSONObject: requestBody, options: [])

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }

        guard let responseString = String(data: data, encoding: .utf8) else {
            throw URLError(.cannotParseResponse)
        }

        return responseString
    }
}
