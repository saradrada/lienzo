//
//  WideButton.swift
//  Lienzo
//
//  Created by Sara Ortiz Drada on 09.08.24.
//

import SwiftUI

struct WideButton: View {
    var text: String
    var action: () -> Void
    var backgroundColor: Color = .cDarkPurple
    var fontColor: Color = .white

    var body: some View {
        Button {
            action()
        } label: {
            Text(text)
                .font(.headline)
                .frame(maxWidth: .infinity)
                .fontWeight(.medium)
                .foregroundColor(fontColor)
                .padding()
                .background(backgroundColor)
                .cornerRadius(10)
        }
    }
}

#Preview {
    WideButton(text: "Button", action: {})
}
