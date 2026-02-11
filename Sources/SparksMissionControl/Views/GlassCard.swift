import SwiftUI

struct GlassCard<Content: View>: View {
    let title: String
    let subtitle: String?
    let icon: String?
    let content: Content

    init(title: String, subtitle: String? = nil, icon: String? = nil, @ViewBuilder content: () -> Content) {
        self.title = title
        self.subtitle = subtitle
        self.icon = icon
        self.content = content()
    }

    private let shape = RoundedRectangle(cornerRadius: Theme.cardCornerRadius, style: .continuous)

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            if !title.isEmpty {
                HStack {
                    Text(title)
                        .font(.system(size: 11, weight: .semibold))
                        .textCase(.uppercase)
                        .tracking(0.8)
                        .foregroundStyle(Theme.textTertiary)
                    Spacer()
                    if let icon {
                        Text(icon)
                            .font(.system(size: 14))
                            .opacity(0.5)
                    }
                }
            }
            if let subtitle {
                Text(subtitle)
                    .font(.caption)
                    .foregroundStyle(Theme.textSecondary)
            }
            content
        }
        .padding(16)
        .background(
            ZStack {
                // Base dark glass
                shape.fill(Theme.glassFill)

                // Subtle inner gradient — lighter at top for liquid depth
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

                // Very faint backdrop material
                shape.fill(.ultraThinMaterial.opacity(0.12))

                // Border
                shape.strokeBorder(Theme.glassStroke, lineWidth: 0.5)

                // Top edge liquid shine
                shape
                    .strokeBorder(
                        LinearGradient(
                            colors: [
                                Theme.topHighlight,
                                Theme.topHighlight.opacity(0.3),
                                .clear,
                                .clear,
                            ],
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

/// Small inner tile used inside glass cards
struct GlassTile<Content: View>: View {
    let content: Content
    init(@ViewBuilder content: () -> Content) { self.content = content() }
    var body: some View {
        content
            .padding(10)
            .background(
                RoundedRectangle(cornerRadius: Theme.innerCardRadius, style: .continuous)
                    .fill(Theme.tileFill)
                    .overlay(
                        RoundedRectangle(cornerRadius: Theme.innerCardRadius, style: .continuous)
                            .strokeBorder(Theme.tileBorder, lineWidth: 0.5)
                    )
            )
    }
}
