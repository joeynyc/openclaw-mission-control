import SwiftUI

struct ModelRoutingCard: View {
    @EnvironmentObject private var appState: AppState

    var body: some View {
        GlassCard(title: "Model Routing", icon: "🧬") {
            VStack(alignment: .leading, spacing: 8) {
                // Primary model — prominent
                HStack(spacing: 8) {
                    Circle().fill(Theme.purple).frame(width: 7, height: 7)
                    Text(shortName(appState.modelRouting.primary))
                        .font(Theme.mono(12, weight: .bold))
                        .foregroundStyle(Theme.purple)
                }
                .padding(.vertical, 6)
                .padding(.horizontal, 10)
                .background(
                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                        .fill(Theme.purple.opacity(0.1))
                        .overlay(
                            RoundedRectangle(cornerRadius: 8, style: .continuous)
                                .strokeBorder(Theme.purple.opacity(0.2), lineWidth: 0.5)
                        )
                )

                // Fallbacks — compact list
                if !appState.modelRouting.fallbackModels.isEmpty {
                    Text("Fallbacks")
                        .font(.system(size: 10, weight: .semibold))
                        .foregroundStyle(Theme.textTertiary)
                        .textCase(.uppercase)

                    FlowLayout(spacing: 5) {
                        ForEach(appState.modelRouting.fallbackModels, id: \.self) { model in
                            Text(shortName(model))
                                .font(Theme.mono(10))
                                .foregroundStyle(Theme.textSecondary)
                                .padding(.horizontal, 7)
                                .padding(.vertical, 3)
                                .background(
                                    RoundedRectangle(cornerRadius: 6, style: .continuous)
                                        .fill(Theme.tileFill)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 6, style: .continuous)
                                                .strokeBorder(Theme.tileBorder, lineWidth: 0.5)
                                        )
                                )
                        }
                    }
                }
            }
        }
    }

    /// Strip provider prefix for cleaner display
    private func shortName(_ model: String) -> String {
        if let slash = model.lastIndex(of: "/") {
            return String(model[model.index(after: slash)...])
        }
        return model
    }
}

/// Simple flow layout for tags
struct FlowLayout: Layout {
    var spacing: CGFloat = 6

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let result = arrange(proposal: proposal, subviews: subviews)
        return result.size
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let result = arrange(proposal: ProposedViewSize(width: bounds.width, height: bounds.height), subviews: subviews)
        for (index, offset) in result.offsets.enumerated() {
            subviews[index].place(at: CGPoint(x: bounds.minX + offset.x, y: bounds.minY + offset.y), proposal: .unspecified)
        }
    }

    private func arrange(proposal: ProposedViewSize, subviews: Subviews) -> (size: CGSize, offsets: [CGPoint]) {
        let maxWidth = proposal.width ?? .infinity
        var offsets: [CGPoint] = []
        var x: CGFloat = 0
        var y: CGFloat = 0
        var rowHeight: CGFloat = 0
        var maxX: CGFloat = 0

        for subview in subviews {
            let size = subview.sizeThatFits(.unspecified)
            if x + size.width > maxWidth, x > 0 {
                x = 0
                y += rowHeight + spacing
                rowHeight = 0
            }
            offsets.append(CGPoint(x: x, y: y))
            rowHeight = max(rowHeight, size.height)
            x += size.width + spacing
            maxX = max(maxX, x)
        }

        return (CGSize(width: maxX, height: y + rowHeight), offsets)
    }
}
