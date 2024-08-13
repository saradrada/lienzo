//
//  TextFieldWithButton.swift
//  Lienzo
//
//  Created by Sara Ortiz Drada on 10.08.24.
//

import SwiftUI

struct TextFieldWithButton: View {
    @Binding var text: String
    var placeholder: String
    var action: () -> Void
    var dropDownItem: [String]

    var body: some View {
        ZStack {
            TextField(placeholder, text: $text)
                .font(.subheadline)
                .padding(.horizontal)
                .padding(.vertical, 8)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.cGray.opacity(0.3))
                )
                .lineLimit(5)
                .disabled(true)
            HStack {
                Spacer()
                Menu {
                    ForEach(dropDownItem, id: \.self){ item in
                        Button(item) {
                            self.text = item
                        }
                    }
                } label: {
                    VStack {
                        Image(systemName: "chevron.down")
                            .foregroundStyle(.cPurple)
                            .padding()
                    }
                }
            }
        }
    }
}

#Preview {
    TextFieldWithButton(text: .constant(""), placeholder: "Placeholder", action: {}, dropDownItem: ["Option 1", "Option 2", "Option 3"])
}
