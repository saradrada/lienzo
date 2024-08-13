//
//  DesignListView.swift
//  Lienzo
//
//  Created by Sara Ortiz Drada on 10.08.24.
//

import SwiftUI

import SwiftUI

struct DesignListView: View {
    let designs: [Design]

//    var body: some View {
//        ScrollView(.horizontal, showsIndicators: false) {
//            HStack(spacing: 24) {
//                ForEach(designs) { design in
//                    NavigationLink(destination: DesignDetailView(design: design)) {
//                        DesignCardView(design: design)
//                    }
//                }
//            }
//            .padding()
//        }
//    }
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 9) {
                ForEach(designs) { design in
                    NavigationLink(destination: DesignDetailView(design: design)) {
                        DesignCardView(design: design, size: 165)
                    }
                }
            }
            .padding()
        }
    }

}

#Preview {
    DesignListView(designs: DesignMocks.designs)
}
