import SwiftUI

struct ServicesCard: View {
    @EnvironmentObject private var appState: AppState

    var body: some View {
        GlassCard(title: "Services", icon: "🟢") {
            VStack(alignment: .leading, spacing: 6) {
                serviceRow("Gateway", value: appState.services.gateway, good: appState.services.gateway == "Running")
                serviceRow("Telegram", value: appState.services.telegram, good: appState.services.telegram == "Connected")
                // Additional services auto-detected from gateway status
                // Users can extend this with their own integrations

                Divider().overlay(Theme.tileBorder)

                HStack {
                    Text("Uptime")
                        .font(.system(size: 11))
                        .foregroundStyle(Theme.textTertiary)
                    Spacer()
                    Text(formatUptime(appState.services.uptime))
                        .font(Theme.mono(11, weight: .bold))
                        .foregroundStyle(Theme.textPrimary)
                }
            }
        }
    }

    private func serviceRow(_ name: String, value: String, good: Bool) -> some View {
        HStack(spacing: 8) {
            Circle()
                .fill(good ? Theme.onlineGreen : Theme.errorRed)
                .frame(width: 6, height: 6)
                .shadow(color: (good ? Theme.onlineGreen : Theme.errorRed).opacity(0.5), radius: 3)

            Text(name)
                .font(.system(size: 12, weight: .medium))
                .foregroundStyle(Theme.textSecondary)

            Spacer()

            Text(value)
                .font(Theme.mono(11, weight: .semibold))
                .foregroundStyle(good ? Theme.onlineGreen : Theme.warningOrange)
        }
    }

    private func formatUptime(_ uptime: TimeInterval?) -> String {
        guard let uptime else { return "—" }
        let total = Int(uptime)
        let hours = total / 3600
        let minutes = (total % 3600) / 60
        let seconds = total % 60
        return String(format: "%02dh %02dm %02ds", hours, minutes, seconds)
    }
}
