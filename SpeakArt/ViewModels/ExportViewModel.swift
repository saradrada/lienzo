//
//  DesignExportViewModel.swift
//  SpeakArt
//
//  Created by Sara Ortiz Drada on 12.08.24.
//

import Foundation
import SwiftUI
import PDFKit

@MainActor
class DesignExportViewModel: ObservableObject {
    @Published var previewURL: URL?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private let exportService: ExportServiceProtocol

    init(exportService: ExportServiceProtocol = ExportService()) {
        self.exportService = exportService
    }

    func exportDesign(designID: String, format: String) async {
        isLoading = true
        do {
            let result = try await exportService.createExport(designID: designID, format: format)
            previewURL = URL(string: result)
            errorMessage = nil
        } catch {
            errorMessage = "Failed to export design: \(error.localizedDescription)"
        }
        isLoading = false
    }
}


struct PDFViewWrapper: UIViewRepresentable {
    let url: URL

    func makeUIView(context: Context) -> PDFView {
        let pdfView = PDFView()
        pdfView.autoScales = true
        if let document = PDFDocument(url: url) {
            pdfView.document = document
        }
        return pdfView
    }

    func updateUIView(_ uiView: PDFView, context: Context) {
        if let document = PDFDocument(url: url) {
            uiView.document = document
        }
    }
}
