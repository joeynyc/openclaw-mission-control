import SwiftUI

struct ActivityLogCard: View {
    @EnvironmentObject private var appState: AppState

    var body: some View {
        GlassCard(title: "Activity Log", icon: "📋") {
            ScrollViewReader { proxy in
                ScrollView {
                    if appState.activityLog.isEmpty {
                        Text("No activity yet")
                            .font(Theme.mono(11))
                            .foregroundStyle(Theme.textTertiary)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.vertical, 20)
                    } else {
                        LazyVStack(alignment: .leading, spacing: 4) {
                            ForEach(appState.activityLog) { entry in
                                HStack(alignment: .top, spacing: 8) {
                                    Circle()
                                        .fill(color(for: entry.level))
                                        .frame(width: 5, height: 5)
                                        .padding(.top, 5)

                                    Text(entry.timestamp, style: .time)
                                        .font(Theme.mono(10))
                                        .foregroundStyle(Theme.textTertiary)
                                        .frame(width: 54, alignment: .leading)

                                    Text("\(entry.title)")
                                        .font(.system(size: 11, weight: .semibold))
                                        .foregroundStyle(color(for: entry.level))
                                    +
                                    Text("  \(entry.detail)")
                                        .font(Theme.mono(10))
                                        .foregroundStyle(Theme.textSecondary)

                                    Spacer()
                                }
                                .id(entry.id)
                            }
                        }
                    }
                }
                .onChange(of: appState.activityLog.count) {
                    guard let lastID = appState.activityLog.last?.id else { return }
                    withAnimation(.easeOut(duration: 0.2)) {
                        proxy.scrollTo(lastID, anchor: .bottom)
                    }
                }
            }
        }
    }

    private func color(for level: ActivityEntry.Level) -> Color {
        switch level {
        case .normal: return Theme.textSecondary
        case .success: return Theme.onlineGreen
        case .warning: return Theme.warningOrange
        case .error: return Theme.errorRed
        }
    }
}
