// SPDX-License-Identifier: MIT
// AsahiRestartHelperApp.swift

import SwiftUI

// A simple menubar-icon-only app to help easily restart their Mac into Linux (or technically any other OS).

// The main struct delegates to AppDelegate for handling all events.
@main
struct AsahiRestartHelperApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        // The body is an empty settings scene: no "traditional" UI (the menubar icon is the only entry point)
        Settings {
            EmptyView()
        }
    }
}
