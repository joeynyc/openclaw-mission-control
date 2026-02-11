import SwiftUI

struct CronJobsCard: View {
    @EnvironmentObject private var appState: AppState

    var body: some View {
        GlassCard(title: "Cron Jobs", icon: "⏰") {
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text("\(appState.cronJobs.count) jobs")
                        .font(Theme.mono(11))
                        .foregroundStyle(Theme.textTertiary)

                    Spacer()

                    Button(action: { Task { await appState.refreshCronJobs() } }) {
                        Image(systemName: "arrow.clockwise")
                            .font(.system(size: 11, weight: .medium))
                            .foregroundStyle(Theme.textSecondary)
                    }
                    .buttonStyle(GlassButtonStyle())
                }

                if appState.cronJobs.isEmpty {
                    Text("No scheduled jobs")
                        .font(.system(size: 11))
                        .foregroundStyle(Theme.textTertiary)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.vertical, 8)
                } else {
                    ForEach(appState.cronJobs) { job in
                        HStack(alignment: .center, spacing: 8) {
                            Circle()
                                .fill(job.enabled ? Theme.onlineGreen : Theme.warningOrange)
                                .frame(width: 6, height: 6)

                            VStack(alignment: .leading, spacing: 2) {
                                Text(job.name)
                                    .font(.system(size: 11, weight: .semibold))
                                    .foregroundStyle(Theme.textPrimary)

                                Text(job.schedule)
                                    .font(Theme.mono(10))
                                    .foregroundStyle(Theme.textTertiary)
                            }

                            Spacer()

                            Button("Run") {
                                Task { await appState.triggerCronJob(job.name) }
                            }
                            .font(.system(size: 10, weight: .bold))
                            .foregroundStyle(Theme.accentYellow)
                            .buttonStyle(GlassButtonStyle())
                        }
                        .padding(8)
                        .background(
                            RoundedRectangle(cornerRadius: 8, style: .continuous)
                                .fill(Theme.tileFill)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                                        .strokeBorder(Theme.tileBorder, lineWidth: 0.5)
                                )
                        )
                    }
                }
            }
        }
    }
}
