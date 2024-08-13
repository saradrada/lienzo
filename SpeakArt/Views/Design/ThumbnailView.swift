//
//  ThumbnailView.swift
//  Lienzo
//
//  Created by Sara Ortiz Drada on 10.08.24.
//

import SwiftUI

struct ThumbnailView: View {
    let thumbnailURL: URL
    let shadow: Bool
    var size: CGSize = CGSize(width: 200, height: 200)

    var body: some View {
        AsyncImage(url: thumbnailURL) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            case .failure:
                Image(systemName: "photo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.gray.opacity(0.3))
            @unknown default:
                Image(systemName: "photo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.gray.opacity(0.3))
            }
        }
        .frame(width: size.width, height: size.height)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadow(radius: shadow ? 5 : 0)
    }
}

#Preview {
//    ThumbnailView(thumbnailURL: URL(string: "bad URL")!, shadow: true)
    ThumbnailView(thumbnailURL: URL(string: DesignMocks.designs[1].thumbnail.url)!, shadow: true)
}
