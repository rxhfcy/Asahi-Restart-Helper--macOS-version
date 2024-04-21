// SPDX-License-Identifier: MIT
// PreferencesDialog.swift

import SwiftUI

// Preferences "dialog" / "window" (technically a popover)
// TODO: or make it look more "native" and "modern" (iOS-like toggles, "disabled" info text etc)?
struct PreferencesDialog: View {
    @Binding var currentView: CurrentView
    let closeAction: () -> Void
    @AppStorage("isLoginItemPreference") var isLoginItem: Bool = false
    @AppStorage("useHelperAppPreference") var useHelperApp: Bool = false
    
    // FIXME: everything is super ugly and HACKY for now, fix and implement correctly at some point
    @State private var showAlert: Bool = false
    
    var body: some View {
        
        VStack {
            Text(NSLocalizedString("PreferencesDialog.Title", comment: ""))
                .font(.headline)
                .padding(.bottom)
            
            HStack {
                Toggle(isOn: $isLoginItem) {
                    Text(NSLocalizedString("PreferencesDialog.AutoStartToggleLabel", comment: ""))
                        .fixedSize(horizontal: false, vertical: true)
                        .help(NSLocalizedString("PreferencesDialog.AutoStartToggleLabelTooltip", comment: ""))
                }
                .onReceive([self.isLoginItem].publisher.first()) { (value) in
                    UserDefaults.standard.set(value, forKey: "isLoginItemPreference")
                }
                .padding(.leading, 10)
                Spacer()
            }
            
            HStack {
                Toggle(isOn: $useHelperApp) {
                    Text(NSLocalizedString("PreferencesDialog.HelperAppToggleLabel", comment: ""))
                        .fixedSize(horizontal: false, vertical: true)
                        .help(NSLocalizedString("PreferencesDialog.HelperAppToggleLabelTooltip", comment: ""))
                }
                .padding(.leading, 10)
                .onChange(of: useHelperApp) { _ in
                    showAlert = true
                }
                Spacer()
            }
            
            Button(
                NSLocalizedString("PreferencesDialog.QuitButton", comment: ""),
                action: {
                    NSApplication.shared.terminate(self)
                }
            )
            .buttonStyle(CustomNormalButtonStyle())
            .padding()
            
            Button("PreferencesDialog.CloseButton", action: self.closeAction)
                .buttonStyle(CustomNormalButtonStyle())
        }
        .padding()
        
        // FIXME: everything is super ugly and HACKY for now, fix and implement correctly at some point
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Dummy Dialog"),
                message: Text("(This will eventually ask for password / Touch ID)"),
                dismissButton: .default(Text("OK")))
        }
    }
}
