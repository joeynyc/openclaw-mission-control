import SwiftUI

struct IdentityCard: View {
    @EnvironmentObject private var appState: AppState

    var body: some View {
        // Identity has no title label — it IS the header
        VStack(spacing: 0) {
            HStack(spacing: 14) {
                // Avatar with glow
                ZStack {
                    RoundedRectangle(cornerRadius: 14, style: .continuous)
                        .fill(
                            LinearGradient(
                                colors: [Theme.accentYellow, Color(hex: 0xFF9F0A)],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: 50, height: 50)
                        .shadow(color: Theme.accentYellow.opacity(0.3), radius: 12, y: 4)

                    Text("⚡")
                        .font(.system(size: 26))
                }

                VStack(alignment: .leading, spacing: 4) {
                    HStack(alignment: .firstTextBaseline, spacing: 8) {
                        Text("Sparks")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundStyle(Theme.textPrimary)

                        // Subtle role tag
                        Text("AGENT")
                            .font(.system(size: 9, weight: .bold))
                            .tracking(1.2)
                            .foregroundStyle(Theme.accentYellow.opacity(0.7))
                            .padding(.horizontal, 6)
                            .padding(.vertical, 2)
                            .background(
                                Capsule()
                                    .fill(Theme.accentYellow.opacity(0.1))
                                    .overlay(
                                        Capsule().strokeBorder(Theme.accentYellow.opacity(0.2), lineWidth: 0.5)
                                    )
                            )
                    }

                    Text("Live wire · Executive Assistant to Joey")
                        .font(.system(size: 12))
                        .foregroundStyle(Theme.textSecondary)

                    HStack(spacing: 8) {
                        HStack(spacing: 4) {
                            Circle().fill(Theme.purple).frame(width: 5, height: 5)
                            Text("claude-opus-4-6")
                                .font(Theme.mono(10))
                                .foregroundStyle(Theme.purple)
                        }

                        Text("·")
                            .foregroundStyle(Theme.textTertiary)

                        HStack(spacing: 4) {
                            Circle()
                                .fill(appState.isConnected ? Theme.onlineGreen : Theme.errorRed)
                                .frame(width: 5, height: 5)
                                .shadow(color: (appState.isConnected ? Theme.onlineGreen : Theme.errorRed).opacity(0.5), radius: 3)

                            Text(appState.isConnected ? "Online" : "Offline")
                                .font(.system(size: 10, weight: .semibold))
                                .foregroundStyle(appState.isConnected ? Theme.onlineGreen : Theme.errorRed)
                        }
                    }
                }

                Spacer(minLength: 0)
            }
        }
        .padding(16)
        .background(
            ZStack {
                let shape = RoundedRectangle(cornerRadius: Theme.cardCornerRadius, style: .continuous)
                shape.fill(Theme.glassFill)
                shape.fill(
                    LinearGradient(
                        colors: [
                            Color.white.opacity(0.04),
                            Color.white.opacity(0.01),
                            Color.clear,
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                shape.fill(.ultraThinMaterial.opacity(0.12))
                shape.strokeBorder(Theme.glassStroke, lineWidth: 0.5)
                shape.strokeBorder(
                    LinearGradient(
                        colors: [Theme.topHighlight, Theme.topHighlight.opacity(0.3), .clear, .clear],
                        startPoint: .top,
                        endPoint: .bottom
                    ),
                    lineWidth: 0.5
                )
            }
        )
        .shadow(color: .black.opacity(0.35), radius: 10, y: 5)
    }
}
