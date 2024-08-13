//
//  DesignService.swift
//  Lienzo
//
//  Created by Sara Ortiz Drada on 11.08.24.
//

import Foundation

protocol DesignServiceProtocol {
    func getDesigns() async throws -> [Design]
}

class DesignService: DesignServiceProtocol {
    func getDesigns() async throws -> [Design] {

        guard let url = URL(string: "https://canva.yesidlopez.de/designs") else {
//        guard let url = URL(string: "http://192.168.2.199:80/designs") else {
            throw URLError(.badURL)
            }

            var request = URLRequest(url: url)
            request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }

        let decoder = JSONDecoder()
        let designs = try decoder.decode([Design].self, from: data)
        return designs
    }
}

