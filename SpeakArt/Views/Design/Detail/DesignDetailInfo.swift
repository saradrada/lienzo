//
//  DesignDetailInfo.swift
//  SpeakArt
//
//  Created by Sara Ortiz Drada on 11.08.24.
//

import SwiftUI

//struct DesignDetailInfo: View {
//    @State private var sentiment: String = ""
//    @State private var additionalNotes: String = ""
//    @State private var targetAudience: String = ""
//    @State private var purpose: String = ""
//    @State private var showHint: Bool = false
//    @ObservedObject var designDetailViewModel: DesignDetailViewModel
//
//    let design: Design
//
//    private var isAnalyzeButtonDisabled: Bool {
//        sentiment.isEmpty || targetAudience.isEmpty || purpose.isEmpty
//    }
//
//    var body: some View {
//        VStack {
//            ZStack {
//                Color.white
//                    .clipShape(RoundedRectangle(cornerRadius: 25.0, style: .continuous))
//                    .edgesIgnoringSafeArea(.bottom)
//
//
//                VStack(alignment: .leading) {
//
//                    HStack {}
//                    Group {
//                        sentimentSection
//                        targetAudienceSection
//                        purposeSection
//                        additionalNotesSection
//                        analyzeButton
//                    }
//                    Spacer()
//                }
//                .padding(.top, 35)
//                .padding(.bottom, 20)
//                .padding(.horizontal, 25)
//            }
//            .frame(height: 550)
//        }
//        .padding(.top, 350)
//    }
//
//    private var sentimentSection: some View {
//        Group {
//            Text("1. Describe the sentiment or theme that best aligns with this design.")
//                .font(.subheadline)
//            TextFieldWithButton(text: $sentiment,
//                                placeholder: "Choose Sentiment/Theme",
//                                action: { },
//                                dropDownItem: designDetailViewModel.getSentimentList()
//            )
//            .padding(.bottom)
//        }
//    }
//
//    private var targetAudienceSection: some View {
//        Group {
//            Text("2. Identify the primary audience this design is meant for.")
//                .font(.subheadline)
//            TextField("", text: $targetAudience, axis: .vertical)
//                .font(.subheadline)
//                .lineLimit(2, reservesSpace: true)
//                .keyboardType(.default)
//                .customTextField()
//                .padding(.bottom)
//        }
//    }
//
//    private var purposeSection: some View {
//        Group {
//            Text("3. Select the primary purpose of your design.")
//                .font(.subheadline)
//            TextFieldWithButton(text: $purpose,
//                                placeholder: "Design Purpose",
//                                action: { self.sentiment = "" },
//                                dropDownItem: designDetailViewModel.getPurposeList()
//            )
//            .padding(.bottom)
//        }
//    }
//
//    private var additionalNotesSection: some View {
//        Section {
//            Text("4. Add any additional information or notes.")
//                .font(.subheadline)
//            TextField("Notes (optional)", text: $additionalNotes, axis: .vertical)
//                .font(.subheadline)
//                .lineLimit(2, reservesSpace: true)
//                .customTextField()
//                .padding(.bottom)
//        }
//    }
//
//    private var analyzeButton: some View {
//        Button {
//            Task {
//                await designDetailViewModel.analyzeDesign(id: design.id, sentiment: sentiment, targetAudience: targetAudience, purpose: purpose, additionalNotes: additionalNotes)
//            }
//        } label: {
//            Text("Analyze Design")
//                .font(.subheadline)
//                .frame(maxWidth: .infinity)
//                .fontWeight(.medium)
//                .foregroundColor(.white)
//                .padding(16)
//                .background(isAnalyzeButtonDisabled ? Color.gray.opacity(0.6) : Color.cDarkPurple)
//                .cornerRadius(10)
//        }
//        .padding(.horizontal, 40)
//        .disabled(isAnalyzeButtonDisabled)
//    }
//}
//
//#Preview {
//    return ScrollView {
//        VStack(alignment: .leading) {
//            ZStack(alignment: .top) {
//                DesignDetailHeader(thumbnail: DesignMocks.designs[0].thumbnail)
//                DesignDetailInfo(designDetailViewModel: DesignDetailViewModel(), design: DesignMocks.designs[0])
//            }
//        }
//    }
//    .ignoresSafeArea()
//}

