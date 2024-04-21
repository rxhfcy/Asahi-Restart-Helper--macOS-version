// SPDX-License-Identifier: MIT
// RestartConfirmationDialog.swift

import SwiftUI

// Restart confirmation "dialog" (technically a popover)

// - Mostly mimics the "native" system Restart dialog
// - Tiny detail: dark theme only: popover background color lighter than the menu or system Restart dialog bg
// - Reason for not directly using the normal system Restart dialog: impossible (?)
// - Reason for not using normal system Restart dialog's "Reopen windows when logging back in" toggle: impossible (?)
struct RestartConfirmationDialog: View {
    let diskNumber: Int
    @EnvironmentObject var appDelegate: AppDelegate
    @Binding var currentView: CurrentView
    @State private var useHelperApp: Bool = UserDefaults.standard.bool(
        forKey: "useHelperAppPreference")
    
    let closeAction: () -> Void
    
    var body: some View {
        VStack {
            Text(NSLocalizedString("RestartConfirmationDialog.Title", comment: ""))
                .font(.headline)
                .multilineTextAlignment(.leading)
                .padding(.top)
            // TODO: decide if displaying the disk name to the user is needed or not (reassuring or too redundant?)
            
            // FIXME: hardcoded for now...
            let osName = "Fedora Linux"
            Text(String(format: NSLocalizedString("RestartConfirmationDialog.IsNext", comment: ""), osName))
                .multilineTextAlignment(.leading)
            // Allow text to wrap onto multiple lines if the disk name is unreasonably long
                .lineLimit(nil)
                .padding(.horizontal)
            
            Text(NSLocalizedString("RestartConfirmationDialog.Warning", comment: ""))
                .multilineTextAlignment(.center)
                .help(NSLocalizedString("RestartConfirmationDialog.WarningTooltip", comment: ""))
                .padding(.horizontal)
                .padding(.top, 8)
            
            HStack {
                Spacer()
                
                Button(
                    NSLocalizedString("RestartConfirmationDialog.CancelButton", comment: ""), action: self.closeAction
                )
                .buttonStyle(CustomNormalButtonStyle())
                
                Button(
                    NSLocalizedString(
                        useHelperApp
                        ? "RestartConfirmationDialog.RestartWithoutPasswordButton" : "RestartConfirmationDialog.RestartButton",
                        comment: "")
                ) {
                    // HACK: attempt to disable the extremely slow closing animation. May not work, but let's try anyway
                    withAnimation(nil) {
                        self.closeAction()
                        // HACK: always wait 500 ms for any animations to finish, closing fails if animation is running!
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            appDelegate.setStartupDiskForNextBootOnlyAndRestart()
                        }
                    }
                }
                // Use custom "accent color button" to mimic system "Restart" button
                .buttonStyle(CustomAccentColorButtonStyle())
                // Tiny detail: increase padding between the buttons to mimic system Restart dialog button spacing
                .padding(.leading, 4)
            }
            .padding(.top, 9)
            .padding(.trailing, 20)
            .padding(.bottom)
        }
    }
}
