// SPDX-License-Identifier: MIT
// AsahiRestartHelperApp.swift

import SwiftUI

// A simple macOS menubar icon app to easily restart your Apple silicon Mac into Linux from macOS (ARM64 Asahi Linux)
// - (users are also encouraged to install the corresponding Linux version, to easily restart in macOS from Linux)

// The main struct delegates to AppDelegate for handling all events
@main
struct AsahiRestartHelperApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        // The body is an empty settings scene (the menubar icon is the only entry point i.e. no "traditional" UI)
        Settings {
            EmptyView()
        }
    }
}
