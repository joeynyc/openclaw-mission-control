import SwiftUI

struct SkillsCard: View {
    @EnvironmentObject private var appState: AppState

    var body: some View {
        GlassCard(title: "Skills", icon: "⚔️") {
            if appState.skills.isEmpty {
                Text("No skills detected")
                    .font(Theme.mono(11))
                    .foregroundStyle(Theme.textTertiary)
            } else {
                FlowLayout(spacing: 5) {
                    ForEach(appState.skills.prefix(24), id: \.self) { skill in
                        Text(skill)
                            .font(Theme.mono(10, weight: .medium))
                            .foregroundStyle(Theme.textSecondary)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(
                                RoundedRectangle(cornerRadius: 7, style: .continuous)
                                    .fill(Theme.tileFill)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 7, style: .continuous)
                                            .strokeBorder(Theme.tileBorder, lineWidth: 0.5)
                                    )
                            )
                    }
                }
            }
        }
    }
}
