//
//  DesignDetailView.swift
//  Lienzo
//
//  Created by Sara Ortiz Drada on 10.08.24.
//

import SwiftUI

struct DesignDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var designDetailViewModel = DesignDetailViewModel()
    let design: Design

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                ZStack(alignment: .top) {
                    DesignDetailHeader(thumbnail: design.thumbnail)
                    DesignDetailsView(designDetailViewModel: designDetailViewModel, design: design)
                }
            }
        }
        .ignoresSafeArea()
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    HStack {
                        Image(systemName: "chevron.left")
                    }
                }
            }
        }
    }
}

#Preview {
    DesignDetailView(design: DesignMocks.designs[1])
}
