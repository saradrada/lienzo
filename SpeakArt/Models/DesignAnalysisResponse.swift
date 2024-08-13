//
//  DesignAnalysisResponse.swift
//  SpeakArt
//
//  Created by Sara Ortiz Drada on 11.08.24.
//

import Foundation

enum SuggestionType: String, Codable {
    case contrastReadability = "Contrast Readability"
    case typography = "Typography"
    case layoutComposition = "Layout Composition"
    case marketingEffectiveness = "Marketing Effectiveness"
}

struct Suggestion: Codable {
    let type: SuggestionType
    let suggestion: String
}

struct ColorPaletteRecommendation: Codable {
    let name: String
    let colors: [String]
}

struct CommentsRecommendation: Codable, Hashable {
    let comment: String
}


// MARK: - DesignAnalysisResponse Struct
struct DesignAnalysisResponse: Codable {
    let suggestions: [Suggestion]
    let colorPaletteRecommendations: [ColorPaletteRecommendation]
    let comments: [CommentsRecommendation]
}
