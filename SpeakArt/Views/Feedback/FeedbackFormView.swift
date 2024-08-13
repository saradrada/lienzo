//
//  FeedbackFormView.swift
//  SpeakArt
//
//  Created by Sara Ortiz Drada on 12.08.24.
//

import SwiftUI

struct FeedbackFormView: View {
    @State private var sentiment: String = ""
    @State private var additionalNotes: String = ""
    @State private var targetAudience: String = ""
    @State private var purpose: String = ""
    @State private var showHint: Bool = false
    @State private var showFeedbackView: Bool = false
    
    @FocusState private var isTargetAudienceFocused: Bool

    @ObservedObject var designDetailViewModel: DesignDetailViewModel
    
    let design: Design
    
    private var isAnalyzeButtonDisabled: Bool {
        sentiment.isEmpty || targetAudience.isEmpty || purpose.isEmpty
    }
    
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
            .onChange(of: designDetailViewModel.isLoading) { isLoading in
                if isLoading {
                    withAnimation {
                        proxy.scrollTo("WaveLoadingView", anchor: .center)
                    }
                }
            }
            .onChange(of: showFeedbackView) { showFeedbackView in
                if showFeedbackView {
                    withAnimation {
                        proxy.scrollTo("FeedbackView", anchor: .top)
                    }
                }
            }
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
                                Text("Design Feedback")
                                    .font(.title2)
                                Text("Overview of your design suggestions and recommendations.")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                    .multilineTextAlignment(.leading)
                                    .lineLimit(2, reservesSpace: true)
                            }
                            .padding(.top)
                            .padding(.bottom, 8)
                            Divider()
                                .padding(.bottom, 24)
                        }
                        .padding(.top, 8)
                        Group {
                            sentimentSection
                            targetAudienceSection
                            purposeSection
                            additionalNotesSection
                            analyzeButton
                        }
                    }
                    .padding(.bottom, 24)
                    .padding(.horizontal, 25)

                    if designDetailViewModel.isLoading {
                        WaveLoadingView()
                            .id("WaveLoadingView")
                            .padding(.top, 24)
                            .padding(.bottom, 48)
                    }

                    if showFeedbackView, let analysis = designDetailViewModel.analysis {
                        Dots()
                        FeedbackView(analysis: analysis)
                            .padding(.bottom, 24)
                            .id("FeedbackView")
                    }
                }
            }
            //            .frame(height: 650)
        }
        .padding(.top, 350)
    }
    
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
    
    private var sentimentSection: some View {
        Group {
            Text("1. Describe the sentiment or theme that best aligns with this design.")
                .font(.subheadline)
                .multilineTextAlignment(.leading)
                .lineLimit(2, reservesSpace: true)
            TextFieldWithButton(text: $sentiment,
                                placeholder: "Choose Sentiment/Theme",
                                action: { },
                                dropDownItem: designDetailViewModel.getSentimentList()
            )
            .padding(.bottom)
        }
    }
    
    private var targetAudienceSection: some View {
        Group {
            Text("2. Identify the primary audience this design is meant for.")
                .font(.subheadline)
                .multilineTextAlignment(.leading)
                .lineLimit(2, reservesSpace: true)
            TextField("", text: $targetAudience, axis: .vertical)
                .font(.subheadline)
                .lineLimit(2, reservesSpace: true)
                .keyboardType(.default)
                .customTextField()
                .padding(.bottom)
                .focused($isTargetAudienceFocused)
        }
    }
    
    private var purposeSection: some View {
        Group {
            Text("3. Select the primary purpose of your design.")
                .font(.subheadline)
            TextFieldWithButton(text: $purpose,
                                placeholder: "Design Purpose",
                                action: { self.sentiment = "" },
                                dropDownItem: designDetailViewModel.getPurposeList()
            )
            .padding(.bottom)
        }
    }
    
    private var additionalNotesSection: some View {
        Section {
            Text("4. Add any additional information or notes.")
                .font(.subheadline)
            TextField("Notes (optional)", text: $additionalNotes, axis: .vertical)
                .font(.subheadline)
                .lineLimit(2, reservesSpace: true)
                .customTextField()
                .padding(.bottom)
        }
    }
    
    private var analyzeButton: some View {
        Button {
            Task {
                await designDetailViewModel.analyzeDesign(id: design.id, sentiment: sentiment, targetAudience: targetAudience, purpose: purpose, additionalNotes: additionalNotes)
                isTargetAudienceFocused = false
                resetFormFields()  // Reset form fields after analysis
                showFeedbackView = true  // Show the FeedbackView below the button
            }
        } label: {
            Text("Analyze Design")
                .font(.subheadline)
                .frame(maxWidth: .infinity)
                .fontWeight(.medium)
                .foregroundColor(.white)
                .padding(16)
                .background(isAnalyzeButtonDisabled ? Color.gray.opacity(0.6) : Color.cDarkPurple)
                .cornerRadius(10)
        }
        .padding(.horizontal, 40)
        .disabled(isAnalyzeButtonDisabled)
        
    }
    
    private func resetFormFields() {
        sentiment = ""
        additionalNotes = ""
        targetAudience = ""
        purpose = ""
    }
}

#Preview {
    FeedbackFormView(designDetailViewModel: DesignDetailViewModel(), design: DesignMocks.designs[0])
}
