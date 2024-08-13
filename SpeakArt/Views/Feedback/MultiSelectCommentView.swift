//
//  MultiSelectCommentView.swift
//  SpeakArt
//
//  Created by Sara Ortiz Drada on 12.08.24.
//

import SwiftUI

struct MultiSelectCommentView: View {
    @State private var selectedComments: Set<String> = []
    @ObservedObject var commentViewModel: CommentViewModel

    let design: Design

    private var isAnalyzeButtonDisabled: Bool {
        selectedComments.isEmpty
    }

    let comments: [CommentsRecommendation]

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            ForEach(comments, id: \.self) { comment in
                CommentOptionView(comment: comment.comment, isSelected: selectedComments.contains(comment.comment)) {
                    if selectedComments.contains(comment.comment) {
                        selectedComments.remove(comment.comment)
                    } else {
                        selectedComments.insert(comment.comment)
                    }
                }
            }

            Button {
                Task {
                    let commentMessage = selectedComments.joined(separator: " ")
                    await commentViewModel.postComments(designID: design.id, comments: Array(selectedComments))


                }            } label: {
                    Text("Post comments")
                        .font(.subheadline)
                        .frame(maxWidth: .infinity)
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                        .padding(16)
                        .background(isAnalyzeButtonDisabled ? Color.gray.opacity(0.6) : Color.cDarkPurple)
                        .cornerRadius(10)
                        .padding(.top, 8)
                }
                .padding(.horizontal, 40)
                .disabled(isAnalyzeButtonDisabled)
        }
        .padding()
        .cornerRadius(12)
    }
}

struct CommentOptionView: View {
    let comment: String
    let isSelected: Bool
    let toggleSelection: () -> Void

    var body: some View {
        Button(action: toggleSelection) {
            HStack {
                Text(comment)
                    .font(.subheadline)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.leading)
                    .padding(.trailing, 8)
                Spacer()
                Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(isSelected ? .cPurple : .gray)
                    .padding(.trailing, 8)
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(isSelected ? Color.purple.opacity(0.1) : Color.white)
                    .shadow(color: Color.gray.opacity(0.4), radius: 4)
            )
        }
    }
}

#Preview {
    MultiSelectCommentView(commentViewModel: CommentViewModel(), design: DesignMocks.designs[1], comments: [
        CommentsRecommendation(comment: "Overall, the design is visually appealing but could benefit from more contrast."),
        CommentsRecommendation(comment: "Consider using a more modern typeface to align with current design trends."),
        CommentsRecommendation(comment: "The layout is clean and easy to navigate.")
    ])
}
