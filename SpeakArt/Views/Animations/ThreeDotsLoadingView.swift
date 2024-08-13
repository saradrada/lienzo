//
//  ThreeDotsLoadingView.swift
//  SpeakArt
//
//  Created by Sara Ortiz Drada on 12.08.24.
//
import SwiftUI

struct DotView: View {
    var color: Color = .blue
    var size: CGFloat = 16

    var upMovement: CGFloat
    var scale: CGFloat

    var body: some View {
        Circle()
            .fill(color)
            .frame(width: size, height: size)
            .scaleEffect(scale)
            .offset(y: upMovement)
    }
}

struct WaveLoadingView: View {
    @State private var animate = false
    private var purple: Color = .cPurple
    private var blue: Color = .cBlue.opacity(0.5)

    private var colors: [Color] {
        [purple.opacity(0.33), purple.opacity(0.66), purple]
    }

    private var colorsOpacity: [Color] {
        [blue.opacity(0.33), blue.opacity(0.66), blue]
    }

    let animationDuration: Double = 0.6
    let animationDelay: Double = 0.2
    let dotSize: CGFloat = 10
    let movementRange: CGFloat = 30

    var body: some View {
        HStack(spacing: 15) {
            ForEach(0..<3) { index in
                DotView(color: animate ? colors[index] : colorsOpacity[index], size: dotSize, upMovement: animate ? -movementRange : 0, scale: animate ? 1.2 : 1)
                    .animation(
                        Animation.easeInOut(duration: animationDuration)
                            .repeatForever(autoreverses: true)
                            .delay(Double(index) * animationDelay),
                        value: animate
                    )
            }
        }
        .onAppear {
            animate = true
        }
    }
}

#Preview {
    WaveLoadingView()
}

struct Dots: View {
    let dotSize: CGFloat = 10
    var body: some View {
        HStack(spacing: 15) {
            ForEach(0..<3) { index in
                Circle()
                    .fill(LinearGradient(gradient:
                                            Gradient(colors: [
                                                .cBlue, .cPurple]),
                                           startPoint: .top,
                                           endPoint: .bottom))
                    .frame(width: dotSize, height: dotSize)
            }
        }
    }
}
