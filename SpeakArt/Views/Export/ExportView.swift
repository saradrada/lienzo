//
//  ExportView.swift
//  SpeakArt
//
//  Created by Sara Ortiz Drada on 12.08.24.
//

import SwiftUI

struct ExportView: View {
    @StateObject private var exportViewModel = DesignExportViewModel()
    @State private var format: String = ""
    @State private var showingPDF = false

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
            .sheet(isPresented: $showingPDF) {
                if let url = exportViewModel.previewURL {
                    PDFViewer(url: url)
                } else {
                    Text("Unable to load PDF.")
                }
            }
        }
        .onChange(of: exportViewModel.previewURL) { _ in
            if exportViewModel.previewURL != nil {
                showingPDF = true  // Show the PDFViewer when the preview URL is set
            }
        }
    }

    var export: some View {
        VStack {
            HStack(alignment: .center) {
                Spacer()
                if let previewURL = exportViewModel.previewURL {
                    PDFViewWrapper(url: previewURL)
                        .frame(maxHeight: 350)
                        .padding()
                        .padding(.bottom, 32)
                }
            }
            if exportViewModel.isLoading {
                WaveLoadingView()
                    .padding(.vertical)
            }
            Spacer()

        }
        .padding()
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
                                Text("Export Design ")
                                    .font(.title2)
                            }
                            .padding(.top)
                            .padding(.bottom, 8)
                            Divider()
                        }
                        .padding(.top, 8)

                        HStack {
                            TextFieldWithButton(text: $format,
                                                placeholder: "File Type",
                                                action: { },
                                                dropDownItem: ["JPG", "PNG", "PDF", "PDF Print", "SVG", "GIF"])
                            Button {
                                Task {
                                    await exportViewModel.exportDesign(designID: design.id, format: format.lowercased())
                                }
                            } label: {
                                Text("Export")
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
                        .padding(.top, 8)

                        export

                    }
                    .padding(.bottom, 8)
                    .padding(.horizontal, 25)

                    Spacer()
                }
            }
            .frame(height: 650)
        }
        .padding(.top, 350)
    }
}


#Preview {
    ExportView(design: DesignMocks.designs[1])
}
