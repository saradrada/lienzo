//
//  HintPopover.swift
//  Lienzo
//
//  Created by Sara Ortiz Drada on 10.08.24.
//

import SwiftUI

struct HintPopover: View {
    @State private var showHint: Bool = false
    var hintDescription: String
    var buttonTrailingValue: CGFloat = 30

    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    withAnimation {
                        showHint.toggle()
                    }
                }) {
                    Image(systemName: "questionmark.circle")
                        .foregroundColor(.cPurple)
                }.padding(.trailing, buttonTrailingValue)
            }
            if showHint {
                VStack {
                    HStack(alignment: .top) {
                        Text(hintDescription)
                            .font(.caption)
                            .padding()
                    }
                    .foregroundStyle(.black)
                    .background(Color.cPurple.opacity(0.1))
                    .cornerRadius(8)
                    .padding()
                }
                .offset(y: -15)
                .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .trailing).combined(with: .opacity)))
            }
        }
        .onTapGesture {
            if showHint {
                withAnimation {
                    showHint = false
                }
            }
        }
    }
}

#Preview {
    HintPopover(hintDescription: "This helps us understand the mood you’re aiming for.")
}
