//
//  SuggestionView.swift
//  SpeakArt
//
//  Created by Sara Ortiz Drada on 12.08.24.
//

import SwiftUI

struct SuggestionView: View {
    let suggestions: [Suggestion]

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            ForEach(suggestions, id: \.suggestion) { suggestion in
                SuggestionRowView(suggestion: suggestion)
            }
        }
        .padding()
        .cornerRadius(12)
    }
}

struct SuggestionRowView: View {
    let suggestion: Suggestion

    var body: some View {
        HStack(alignment: .top) {
            Text(suggestionEmoji(for: suggestion.type))
                .font(.title)

            VStack(alignment: .leading) {
                Text(suggestion.suggestion)
                    .font(.subheadline)
                Text(suggestion.type.rawValue)
                    .font(.caption)
                    .foregroundColor(.cDarkPurple)
                    .padding(.vertical, 4)
                    .padding(.horizontal, 8)
                    .background(.cPurple.opacity(0.075))
                    .cornerRadius(4)
            }
            Spacer()
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.gray.opacity(0.2), radius: 4, x: 0, y: 2)
    }

    private func suggestionEmoji(for type: SuggestionType) -> String {
        switch type {
        case .contrastReadability:
            return "🔍"
        case .typography:
            return "✍️"
        case .layoutComposition:
            return "📐"
        case .marketingEffectiveness:
            return "💼"
        }
    }
}

#Preview {
    SuggestionView(suggestions: [
        Suggestion(type: .contrastReadability, suggestion: "Increase contrast between text and background."),
        Suggestion(type: .typography, suggestion: "Use a more modern typeface for headings."),
        Suggestion(type: .layoutComposition, suggestion: "Align elements to create a balanced layout.")
    ])
}
