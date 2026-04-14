import SwiftUI

struct PreferencesWindow: View {
    var body: some View {
        TabView {
            SettingsView()
                .tabItem {
                    Label("Cài đặt", systemImage: "gear")
                }
        }
        .padding()
    }
}
