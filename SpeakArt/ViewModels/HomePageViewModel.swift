//
//  HomePageViewModel.swift
//  Lienzo
//
//  Created by Sara Ortiz Drada on 11.08.24.
//

import Foundation

class HomePageViewModel: ObservableObject {
    @Published var designs: [Design] = []
    @Published var isLoading: Bool = false

    private let designService: DesignServiceProtocol

    init(designService: DesignServiceProtocol = DesignService()) {
        self.designService = designService
        Task {
            await fetchDesigns()
        }
    }

    @MainActor
    func fetchDesigns() async {
        isLoading = true
        do {
            let fetchedDesigns = try await designService.getDesigns()
            designs = fetchedDesigns
        } catch {
            print("Failed to load designs: \(error.localizedDescription)")
        }
        isLoading = false
    }
}
