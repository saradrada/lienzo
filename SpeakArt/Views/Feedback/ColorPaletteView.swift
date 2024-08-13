//
//  ColorPaletteView.swift
//  SpeakArt
//
//  Created by Sara Ortiz Drada on 12.08.24.
//

import SwiftUI

struct ColorPaletteView: View {
    let palette: ColorPaletteRecommendation
    @State private var isLiked: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 0) {
                ForEach(palette.colors, id: \.self) { colorHex in
                    let color = Color(hex: colorHex)
                    ZStack(alignment: .bottomLeading) {
                        color
                            .frame(height: 100)

                        Text(colorHex.uppercased())
                            .font(.caption)
                            .foregroundColor(color.idealTextColor())
                            .padding(.leading, 8)
                            .padding(.bottom, 4)
                    }
                }
            }
            .cornerRadius(10)
            HStack {
                Text(palette.name)
                    .font(.subheadline)
                    .foregroundColor(.gray)

                Spacer()

                HStack(spacing: 4) {
                    Button {
                        withAnimation(.easeInOut) {
                            isLiked.toggle()
                        }
                    } label: {
                        Image(systemName: isLiked ? "heart.fill" : "heart")
                            .foregroundColor(isLiked ? .cPurple : .gray)
                    }
                }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.gray.opacity(0.2), radius: 4)
    }
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }

    // Calculate luminance and return appropriate text color
    func idealTextColor() -> Color {
        let components = self.uiColorComponents()
        let luminance = (0.299 * components.red + 0.587 * components.green + 0.114 * components.blue)

        // If luminance is high, return black; otherwise, return white
        return luminance > 0.5 ? .black : .white
    }

    // Helper function to get the RGB components from the Color as a UIColor
    private func uiColorComponents() -> (red: CGFloat, green: CGFloat, blue: CGFloat) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
//        var alpha: CGFloat = 0

        if let uiColor = UIColor(self).cgColor.components, uiColor.count >= 3 {
            red = uiColor[0]
            green = uiColor[1]
            blue = uiColor[2]
        }

        return (red, green, blue)
    }
}

#Preview {
    var colorPaletteRecommendations =  [
        ColorPaletteRecommendation(name: "Warm Palette", colors: ["#FF5733", "#FFC300", "#FF5733"]),
        ColorPaletteRecommendation(name: "Cool Palette", colors: ["#3498DB", "#2ECC71", "#1ABC9C"]),
        ColorPaletteRecommendation(name: "Neutral Palette", colors: ["#95A5A6", "#BDC3C7", "#7F8C8D"])
    ]

    return ColorPaletteView(palette: colorPaletteRecommendations[0])
}
