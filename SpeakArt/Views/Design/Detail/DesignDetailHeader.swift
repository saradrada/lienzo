//
//  DesignDetailHeader.swift
//  SpeakArt
//
//  Created by Sara Ortiz Drada on 11.08.24.
//

import SwiftUI

struct DesignDetailHeader: View {
    let thumbnail: Design.Thumbnail
    @State private var showImagePreview = false

    var body: some View {
        Group {
            LinearGradient(gradient:
                            Gradient(colors: [
                                Color.cPurple.opacity(0.2),
                                Color.cGray]),
                           startPoint: .top,
                           endPoint: .bottom)
            .frame(height: 450)
            .edgesIgnoringSafeArea(.vertical)
            .offset(CGSize(width: 0, height: -10))

            Button {
                showImagePreview = true
            } label: {
                ThumbnailView(
                    thumbnailURL: URL(string: thumbnail.url)!,
                    shadow: false,
                    size: CGSize(width: 270, height: 270)
                )
            }
            .padding(.top, 60)
            .background(
                Image("logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 400)
                    .opacity(0.5)
                    .clipped()
            )
            .sheet(isPresented: $showImagePreview) {
                ImagePreviewView(thumbnail: thumbnail)
            }

        }
    }
}

#Preview {
    return ScrollView {
        VStack(alignment: .leading) {
            ZStack(alignment: .top) {
                DesignDetailHeader(thumbnail: DesignMocks.designs[0].thumbnail)
            }
        }
    }
    .ignoresSafeArea()
}
