// SPDX-License-Identifier: MIT
// HelpDialog.swift

import SwiftUI

// Help "dialog" (technically a popover)
// TODO: Actually implement and show it to the user (from a button in preferences dialog?)
struct HelpDialog: View {
    @Binding var currentView: CurrentView
    let closeAction: () -> Void
    
    var body: some View {
        VStack {
            Text(NSLocalizedString("HelpDialog.Title", comment: ""))
                .font(.headline)
                .padding(.bottom)
            
            Text(NSLocalizedString("HelpDialog.Text", comment: ""))
                .padding(.bottom)
            
            Button(NSLocalizedString("HelpDialog.CloseButton", comment: ""), action: self.closeAction)
                .buttonStyle(CustomNormalButtonStyle())
        }
        .padding()
    }
}
