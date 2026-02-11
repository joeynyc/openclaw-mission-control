import AppKit
import SwiftUI

@main
struct SparksMissionControlApp: App {
    @StateObject private var appState = AppState()

    var body: some Scene {
        WindowGroup {
            DashboardView()
                .environmentObject(appState)
                .preferredColorScheme(.dark)
                .background(WindowConfigurator())
        }
        .windowStyle(.hiddenTitleBar)
        .defaultSize(width: 1280, height: 900)
    }
}

private struct WindowConfigurator: NSViewRepresentable {
    func makeNSView(context: Context) -> NSView {
        let view = NSView()
        DispatchQueue.main.async {
            configure(window: view.window)
        }
        return view
    }

    func updateNSView(_ nsView: NSView, context: Context) {
        DispatchQueue.main.async {
            configure(window: nsView.window)
        }
    }

    private func configure(window: NSWindow?) {
        guard let window else { return }
        window.titleVisibility = .hidden
        window.titlebarAppearsTransparent = true
        window.styleMask.insert(.fullSizeContentView)
        window.isMovableByWindowBackground = true
        window.isOpaque = true
        window.backgroundColor = NSColor(red: 0.02, green: 0.02, blue: 0.024, alpha: 1.0)
        // Remove the toolbar separator line
        window.toolbarStyle = .unified
        window.minSize = NSSize(width: 900, height: 600)
    }
}
