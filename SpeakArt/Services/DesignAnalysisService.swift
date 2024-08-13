//
//  DesignAnalysisService.swift
//  Lienzo
//
//  Created by Sara Ortiz Drada on 10.08.24.
//



import Foundation

protocol DesignAnalysisServiceProtocol {
    func analyzeDesign(id: String, prompt: String) async throws -> DesignAnalysisResponse
}

class DesignAnalysisService: DesignAnalysisServiceProtocol {
    private let baseURL = "https://canva.yesidlopez.de/designs/"
//    private let baseURL = "http://192.168.2.199:80/designs/"

    func analyzeDesign(id: String, prompt: String) async throws -> DesignAnalysisResponse {
        guard let encodedPrompt = prompt.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: "\(baseURL)\(id)/analyze?prompt=\(encodedPrompt)") else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }

        let designAnalysisResponse = try JSONDecoder().decode(DesignAnalysisResponse.self, from: data)
        return designAnalysisResponse
    }
}

