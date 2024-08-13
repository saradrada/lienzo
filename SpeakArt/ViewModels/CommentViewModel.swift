//
//  CommentViewModel.swift
//  SpeakArt
//
//  Created by Sara Ortiz Drada on 12.08.24.
//

import Foundation

@MainActor
class CommentViewModel: ObservableObject {
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private let commentService: CommentServiceProtocol

    init(commentService: CommentServiceProtocol = CommentService()) {
        self.commentService = commentService
    }

    func postComments(designID: String, comments: [String]) async {
        isLoading = true
        do {
            for comment in comments {
                let response = try await commentService.createComment(designID: designID, message: comment)
                print("Comment posted successfully: \(response)")
            }
            errorMessage = nil  // Clear any previous error messages
        } catch {
            print("Failed to post comment: \(error.localizedDescription)")
            errorMessage = "Failed to post comment: \(error.localizedDescription)"
        }
        isLoading = false
    }
}
