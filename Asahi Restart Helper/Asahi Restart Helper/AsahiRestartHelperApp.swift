// AsahiRestartHelperApp.swift

import SwiftUI

@main
struct AsahiRestartHelperApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        Settings {
            EmptyView()
        }
    }
}
