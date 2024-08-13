//
//  FeedbackView.swift
//  SpeakArt
//
//  Created by Sara Ortiz Drada on 12.08.24.
//

import SwiftUI

struct FeedbackView: View {
    @State private var shouldNavigateToFeedbackView = false
    let analysis: DesignAnalysisResponse

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Analysis Result")
                        .font(.title2)
                        .padding(.bottom, 8)
                    Divider()
                }
                .padding(.horizontal)

                VStack(alignment: .leading, spacing: 8) {
                    Text("Suggestions")
                        .font(.title3)
                        .padding(.horizontal)
                    SuggestionView(suggestions: analysis.suggestions)
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Color Palette Recommendations")
                        .font(.title3)
                        .padding(.horizontal)

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 4) {
                            ForEach(analysis.colorPaletteRecommendations, id: \.name) { palette in
                                ColorPaletteView(palette: palette)
                                    .frame(width: 250)
                                    .padding(8)
                            }
                        }
                    }
                }
            }
            .padding(16)
        }
        .background(Color.white)
    }
}


#Preview {
    var analysis = DesignAnalysisResponse(
        suggestions: [
            Suggestion(type: .contrastReadability, suggestion: "Increase contrast between text and background for better readability."),
            Suggestion(type: .typography, suggestion: "Use a bolder font for headings to improve hierarchy."),
            Suggestion(type: .layoutComposition, suggestion: "Align elements to create a more balanced layout."),
            Suggestion(type: .marketingEffectiveness, suggestion: "Include a clear call-to-action to enhance marketing effectiveness.")
        ],
        colorPaletteRecommendations: [
            ColorPaletteRecommendation(name: "Warm Palette", colors: ["#FF5733", "#FFC300", "#FF5733"]),
            ColorPaletteRecommendation(name: "Cool Palette", colors: ["#3498DB", "#2ECC71", "#1ABC9C"]),
            ColorPaletteRecommendation(name: "Neutral Palette", colors: ["#95A5A6", "#BDC3C7", "#7F8C8D"])
        ],
        comments: [
            CommentsRecommendation(comment: "Overall, the design is visually appealing but could benefit from more contrast."),
            CommentsRecommendation(comment: "Consider using a more modern typeface to align with current design trends."),
            CommentsRecommendation(comment: "The layout is clean and easy to navigate.")
        ]
    )
    return FeedbackView(analysis: analysis)
}
