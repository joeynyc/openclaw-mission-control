import SwiftUI

extension Color {
    init(hex: UInt32, alpha: Double = 1.0) {
        let red = Double((hex >> 16) & 0xFF) / 255.0
        let green = Double((hex >> 8) & 0xFF) / 255.0
        let blue = Double(hex & 0xFF) / 255.0
        self.init(.sRGB, red: red, green: green, blue: blue, opacity: alpha)
    }
}

enum Theme {
    static let baseBackground = Color(hex: 0x050506)
    // Deep black glass fill — NOT using system materials (too gray on macOS)
    static let glassFill = Color(hex: 0x161619, alpha: 0.92)
    static let glassOverlay = Color.white.opacity(0.045)
    static let glassStroke = Color.white.opacity(0.12)
    static let topHighlight = Color.white.opacity(0.18)

    static let accentYellow = Color(hex: 0xFFD60A)
    static let onlineGreen = Color(hex: 0x30D158)
    static let errorRed = Color(hex: 0xFF453A)
    static let warningOrange = Color(hex: 0xFF9F0A)
    static let blue = Color(hex: 0x0A84FF)
    static let purple = Color(hex: 0xBF5AF2)
    static let teal = Color(hex: 0x64D2FF)

    static let textPrimary = Color.white.opacity(0.92)
    static let textSecondary = Color.white.opacity(0.55)
    static let textTertiary = Color.white.opacity(0.35)

    static let cardCornerRadius: CGFloat = 16
    static let innerCardRadius: CGFloat = 10

    static let ambientGradient = LinearGradient(
        colors: [
            Color(hex: 0x050506),
            Color(hex: 0x080809),
            Color(hex: 0x050506),
        ],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )

    // Subtle ambient glow orbs — very dim
    static let ambientOrbs = [
        Color(hex: 0xFFD60A, alpha: 0.04),
        Color(hex: 0x0A84FF, alpha: 0.03),
        Color(hex: 0x30D158, alpha: 0.025),
    ]

    /// Inner list/tile background
    static let tileFill = Color.white.opacity(0.03)
    static let tileBorder = Color.white.opacity(0.05)

    static func mono(_ size: CGFloat, weight: Font.Weight = .regular) -> Font {
        .system(size: size, weight: weight, design: .monospaced)
    }
}

/// Button style with hover glow
struct GlassButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .opacity(configuration.isPressed ? 0.7 : 1.0)
            .scaleEffect(configuration.isPressed ? 0.97 : 1.0)
            .animation(.easeOut(duration: 0.15), value: configuration.isPressed)
    }
}
