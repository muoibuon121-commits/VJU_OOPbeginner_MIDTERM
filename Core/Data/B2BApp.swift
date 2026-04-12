import SwiftUI
import CoreData

@main
struct MyApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
        #if os(macOS)
        .commands {
            // macOS specific commands can be added here
            CommandMenu("Custom Menu") {
                Button("Do Something") {
                    // Action here
                }
                .keyboardShortcut("D", modifiers: [.command])
            }
        }
        #endif
    }
}
