import SwiftUI
import AppKit

struct MainWindow: View {
    @State private var selectedTab: String = "invoices"

    var body: some View {
        ZStack {
            // True Liquid Glass — blur through to desktop
            VisualEffectBlur(material: .windowBackground, blendingMode: .behindWindow)
                .ignoresSafeArea()

            // Subtle dark tint so text stays readable
            Color(red: 0.04, green: 0.04, blue: 0.08).opacity(0.72)
                .ignoresSafeArea()

            HStack(spacing: 0) {
                MainSidebar(selectedTab: $selectedTab)
                    .frame(width: 216)

                // Glass divider
                Rectangle()
                    .fill(Color.white.opacity(0.07))
                    .frame(width: 1)

                ZStack {
                    switch selectedTab {
                    case "dashboard": DashboardView()
                    case "invoices":  InvoiceListView()
                    case "clients":   ClientsListView()
                    case "settings":  SettingsView()
                    default:          EmptyView()
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .frame(minWidth: 960, minHeight: 620)
        .onAppear { configureWindow() }
    }

    private func configureWindow() {
        guard let window = NSApp.windows.first else { return }
        window.isOpaque = false
        window.backgroundColor = .clear
        window.titlebarAppearsTransparent = true
        window.titleVisibility = .hidden
        window.styleMask.insert(.fullSizeContentView)
    }
}
