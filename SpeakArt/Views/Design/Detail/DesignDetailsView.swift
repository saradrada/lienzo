//
//  DesignDetailsView.swift
//  SpeakArt
//
//  Created by Sara Ortiz Drada on 12.08.24.
//

import SwiftUI

struct DesignDetailsView: View {
    @ObservedObject var designDetailViewModel: DesignDetailViewModel

    let design: Design

    var body: some View {
        VStack(alignment: .leading) {
            ZStack {
                Color.white
                    .clipShape(RoundedRectangle(cornerRadius: 25.0, style: .continuous))
                    .edgesIgnoringSafeArea(.bottom)

                VStack(alignment: .leading, spacing: 16) {
                    DesignActionButtonsView(edit: design.urls.editURL, view: design.urls.viewURL)
                    NavigationLink(destination: FeedbackFormView(designDetailViewModel: designDetailViewModel, design: design) ) {
                        feedbackSection
                    }
                    NavigationLink(destination: CommentsView(analysis: designDetailViewModel.analysis, design: design)) {
                        commentsSection
                    }

                    NavigationLink(destination: ARVisualizer(design: design)) {
                        aRVisualizerSection
                    }


                    NavigationLink(destination: ExportView(design: design)) {
                        exportSection
                            .padding(.bottom, 24)
                    }

                    Spacer()
                }
                .padding(.bottom, 20)
                .padding(.horizontal, 25)
            }
            .frame(height: 600)
        }
        .padding(.top, 375)
    }

    private var feedbackSection: some View {
            HStack(alignment: .center) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Feedback")
                        .font(.body)
                        .foregroundColor(.primary)

                    Text("Get instant suggestions to enhance your Canva designs. Improve your color palette, and generate comments to post directly on your design.")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .lineLimit(3)
                        .multilineTextAlignment(.leading)
                }
                Spacer()

                Image(systemName: "chevron.right")
                    .font(.title3)
                    .foregroundColor(.cPurple)
            }
            .frame(height: 90)
            .padding()
            .background(Color.white)
            .cornerRadius(12)
            .shadow(color: Color.gray.opacity(0.2), radius: 4, x: 0, y: 2)
    }

    private var commentsSection: some View {
            HStack(alignment: .center) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Comments")
                        .font(.body)
                        .foregroundColor(.primary)

                    Text("Automatically generated comments tailored to your design. Send them directly to Canva with just a tap.")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .lineLimit(3)
                        .multilineTextAlignment(.leading)
                }
                Spacer()

                Image(systemName: "chevron.right")
                    .font(.title3)
                    .foregroundColor(.cPurple)
            }
            .frame(height: 90)
            .padding()
            .background(Color.white)
            .cornerRadius(12)
            .shadow(color: Color.gray.opacity(0.2), radius: 4, x: 0, y: 2)
    }

    private var aRVisualizerSection: some View {
            HStack(alignment: .center) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Live Visualizer")
                        .font(.body)
                        .foregroundColor(.primary)

                    Text("Experience your designs in augmented reality. Visualize how your work will look in the real world, right from your screen.")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .lineLimit(3)
                        .multilineTextAlignment(.leading)
                }
                Spacer()

                Image(systemName: "chevron.right")
                    .font(.title3)
                    .foregroundColor(.cPurple)
            }
            .frame(height: 90)
            .padding()
            .background(Color.white)
            .cornerRadius(12)
            .shadow(color: Color.gray.opacity(0.2), radius: 4, x: 0, y: 2)
    }

    private var exportSection: some View {
            HStack(alignment: .center) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Export Design")
                        .font(.body)
                        .foregroundColor(.primary)

                    Text("Seamlessly export your refined design from Canva with a single click, ready to share or use in your next project.")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .lineLimit(3)
                        .multilineTextAlignment(.leading)
                }
                Spacer()

                Image(systemName: "chevron.right")
                    .font(.title3)
                    .foregroundColor(.cPurple)
            }
            .frame(height: 90)
            .padding()
            .background(Color.white)
            .cornerRadius(12)
            .shadow(color: Color.gray.opacity(0.2), radius: 4, x: 0, y: 2)
    }
}

import SwiftUI

struct DesignActionButtonsView: View {
    let edit: String
    let view: String

    var body: some View {
        HStack(spacing: 16) {
            viewButton
            editButton
        }
        .offset(x:0, y: -10)
        .padding(.horizontal, 75)
    }

    private var editButton: some View {
        Button {
            if let url = URL(string: edit) {
                UIApplication.shared.open(url)
            }
        } label: {
            Text("Edit")
                .font(.subheadline)
                .frame(maxWidth: .infinity)
                .fontWeight(.medium)
                .foregroundColor(.white)
                .padding(10)
                .background(LinearGradient(gradient:
                                            Gradient(colors: [
                                                .cBlue, .cPurple]),
                                           startPoint: .top,
                                           endPoint: .bottom))
                .cornerRadius(50)
        }
    }

    private var viewButton: some View {
        Button {
            if let url = URL(string: view) {
                UIApplication.shared.open(url)
            }
        } label: {
            Text("View")
                .font(.subheadline)
                .frame(maxWidth: .infinity)
                .fontWeight(.medium)
                .foregroundColor(.white)
                .padding(10)
                .background(LinearGradient(gradient:
                                            Gradient(colors: [
                                                .cBlue, .cPurple]),
                                           startPoint: .top,
                                           endPoint: .bottom))
                .cornerRadius(50)
        }
    }
}

#Preview {
    return ScrollView {
        VStack(alignment: .leading) {
            ZStack(alignment: .top) {
                DesignDetailHeader(thumbnail: DesignMocks.designs[1].thumbnail)
                DesignDetailsView(designDetailViewModel: DesignDetailViewModel(), design: DesignMocks.designs[0])
            }
        }
    }
    .ignoresSafeArea()
}

