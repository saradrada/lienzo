//
//  CommentsView.swift
//  SpeakArt
//
//  Created by Sara Ortiz Drada on 12.08.24.
//

import SwiftUI

struct CommentsView: View {
    @StateObject private var commentViewModel = CommentViewModel()
    let analysis: DesignAnalysisResponse?
    let design: Design

    var body: some View {
        ScrollViewReader { proxy in
            ScrollView {
                VStack(alignment: .leading) {
                    ZStack(alignment: .top) {
                        DesignDetailHeader(thumbnail: design.thumbnail)
                        form
                    }
                }
            }
            .ignoresSafeArea()

        }
    }

    private var form: some View {
        VStack {
            ZStack {
                Color.white
                    .clipShape(RoundedRectangle(cornerRadius: 25.0, style: .continuous))
                    .edgesIgnoringSafeArea(.bottom)
                VStack {
                    VStack(alignment: .leading) {
                        VStack(alignment: .leading) {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Comments Suggestions")
                                    .font(.title2)
                                Text("Automatically generated comments tailored to your design. Send them directly to Canva with just a tap.")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                    .multilineTextAlignment(.leading)
                                    .lineLimit(3, reservesSpace: true)
                            }
                            .padding(.top)
                            .padding(.bottom, 8)
                            Divider()
                        }
                        .padding(.top, 8)

                    }
                    .padding(.bottom, 8)
                    .padding(.horizontal, 25)
                    if let comments = analysis?.comments {
                        VStack(alignment: .leading, spacing: 8) {
                            MultiSelectCommentView(commentViewModel: commentViewModel, design: design, comments: comments)
                        }
                    }
                    Spacer()
                }
            }
            .frame(height: 650)
        }
        .padding(.top, 350)
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
    return CommentsView(analysis: analysis, design: DesignMocks.designs[0])
}
