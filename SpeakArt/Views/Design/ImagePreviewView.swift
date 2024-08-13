//
//  ImagePreviewView.swift
//  Lienzo
//
//  Created by Sara Ortiz Drada on 10.08.24.
//

import SwiftUI

struct ImagePreviewView: View {
    let thumbnail: Design.Thumbnail

    var body: some View {
        ZStack {
            AsyncImage(url: URL(string: thumbnail.url)!) { image in
                VStack {
                    image
                        .resizable()
                        .scaledToFill()
                        .blur(radius: 20)
                        .opacity(0.4)
                        .edgesIgnoringSafeArea(.all)
                }
            } placeholder: {
                Color.gray
                    .blur(radius: 20)
                    .edgesIgnoringSafeArea(.all)
            }

            AsyncImage(url: URL(string: thumbnail.url)!) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300)
                    .shadow(radius: 10)

                Text("\(thumbnail.width) x \(thumbnail.height)")
                    .font(.caption)
                    .foregroundStyle(.cDarkPurple)
                    .padding(.top, 8)

                Image("logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100)
                    .opacity(0.5)
                    .padding(.top, 8)


            } placeholder: {
                ProgressView()
                    .frame(width: 300, height: 300)
                    .background(Color.gray.opacity(0.2))
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .shadow(radius: 10)
            }
        }
    }
}


#Preview {
    ImagePreviewView(thumbnail: DesignMocks.designs[1].thumbnail)
}
