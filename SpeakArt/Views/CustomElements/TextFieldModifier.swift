//
//  TextFieldModifier.swift
//  Lienzo
//
//  Created by Sara Ortiz Drada on 09.08.24.
//

import SwiftUI

struct TextFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.subheadline)
            .padding(.horizontal)
            .padding(.vertical, 8)
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.cGray, lineWidth: 0.8))
            .lineLimit(5)
    }
}

extension View {
    func customTextField() -> some View {
        modifier(TextFieldModifier())
    }
}

#Preview {
    TextField("Placeholder", text: .constant(""))
        .customTextField()
}
