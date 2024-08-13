//
//  DesignCardView.swift
//  Lienzo
//
//  Created by Sara Ortiz Drada on 10.08.24.
//

import SwiftUI

struct DesignCardView: View {
    let design: Design
    var size: Int = 200

    var body: some View {
        VStack(alignment: .leading) {
            ThumbnailView(thumbnailURL: URL(string: design.thumbnail.url)!, shadow: true, size: CGSize(width: size, height: size))
            Spacer()
            Text(design.title ?? "Untitled")
                .font(.body)
                .foregroundColor(.primary)
                .lineLimit(2)
                .multilineTextAlignment(.leading)
                .padding(.top, 4)
                .padding(.bottom, 16)
                .frame(maxWidth: CGFloat(size), alignment: .leading)
        }
    }
}

#Preview {
    DesignCardView(design: DesignMocks.designs[0])
}
