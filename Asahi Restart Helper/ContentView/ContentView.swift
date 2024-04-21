// SPDX-License-Identifier: MIT
// ContentView.swift

import SwiftUI

// For reusing the "same" popover
enum CurrentView {
    case restartConfirmation(Int)
    // case startupDiskConfirmation
    case preferences
    case help
}

// The app (mostly) uses popovers (a "menubar icon speech bubble") for "dialogs" and "windows"
// - Reason: encountered annoying macOS dialog focusing bugs/restrictions
//   (it was too annoying to reliably always show (and/or focus) dialogs opened by a menubar app)
// - Also, popovers are arguably "modern-looking"
struct ContentView: View {
    @ObservedObject var appDelegate: AppDelegate
    @State private var currentView: CurrentView = .restartConfirmation(1)
    
    var body: some View {
        VStack {
            // Fetch "localized" popover width from Localizable.strings, or use fallback value if fetching fails
            switch currentView {
                case .restartConfirmation(let diskNumber):
                    RestartConfirmationDialog(
                        diskNumber: diskNumber,
                        currentView: $currentView, closeAction: { appDelegate.closePopover(nil) }
                    )
                    .frame(
                        width: CGFloat(
                            Int(NSLocalizedString("RestartConfirmationDialog.Width", comment: ""))
                            ?? AppDelegate.fallbackRestartConfirmationPopoverWidth)
                    )
                    .environmentObject(appDelegate)
                case .preferences:
                    PreferencesDialog(currentView: $currentView, closeAction: { appDelegate.closePopover(nil) })
                        .frame(
                            width: CGFloat(
                                Int(NSLocalizedString("PreferencesDialog.Width", comment: ""))
                                ?? AppDelegate.fallbackPreferencesPopoverWidth))
                case .help:
                    HelpDialog(currentView: $currentView, closeAction: { appDelegate.closePopover(nil) })
                        .frame(
                            width: CGFloat(
                                Int(NSLocalizedString("HelpDialog.Width", comment: ""))
                                ?? AppDelegate.fallbackHelpPopoverWidth))
            }
        }
        .onReceive(appDelegate.$currentView) { newView in
            currentView = newView
        }
    }
}
