//
//  DesignDetailViewModel.swift
//  Lienzo
//
//  Created by Sara Ortiz Drada on 10.08.24.
//

import Foundation

@MainActor
class DesignDetailViewModel: ObservableObject {

    @Published var isLoading: Bool = false
    @Published var analysis: DesignAnalysisResponse?
    private let designAnalysisService: DesignAnalysisServiceProtocol

    init(service: DesignAnalysisServiceProtocol = DesignAnalysisService()) {
        self.designAnalysisService = service
    }

    func analyzeDesign(id: String, sentiment: String, targetAudience: String, purpose: String, additionalNotes: String) async {
        analysis = nil
        isLoading = true
        Task {
            do {
                let response = try await designAnalysisService.analyzeDesign(id: id, prompt: formatedPromptInfo(sentiment: sentiment, targetAudience: targetAudience, purpose: purpose, additionalNotes: additionalNotes))
                analysis = response
                isLoading = false
            } catch {
                isLoading = false
                print("Error analyzing design: \(error)")
            }
        }
    }

    func getSentimentList() -> [String] {
        return ["Warm", "Vibrant", "Professional", "Nostalgic", "Playful", "Minimalist", "Bold", "Elegant", "Friendly", "Serious"]

    }

    func getPurposeList() -> [String] {
        return [
            "Poster",
            "Social Media Ad",
            "Print Flyer",
            "Event Invitation",
            "Business Card",
            "Banner (Digital or Print)",
            "Email Header",
            "Presentation Slide",
            "Product Label",
            "Brochure"
        ]

    }

    private func formatedPromptInfo(sentiment: String, targetAudience: String, purpose: String, additionalNotes: String) -> String {
        return """
           The user is using this design with the followin idea in mind:
           This design has a sentiment of \(sentiment), intended for an audience of \(targetAudience).
           The primary purpose of this design is \(purpose).
           Additional notes: \(additionalNotes.isEmpty ? "None" : additionalNotes).
           """
    }
}
