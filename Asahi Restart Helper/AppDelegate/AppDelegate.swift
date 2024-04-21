// SPDX-License-Identifier: MIT
// AppDelegate.swift

import Cocoa
import SwiftUI

class AppDelegate: NSObject, NSApplicationDelegate, NSPopoverDelegate, ObservableObject {
    // Fallback values for popover widths, in case fetching from Localizable.strings fails (wide, to fit "anything")
    static let fallbackRestartConfirmationPopoverWidth = 500
    static let fallbackStartupDiskConfirmationPopoverWidth = 500
    static let fallbackPreferencesPopoverWidth = 500
    static let fallbackHelpPopoverWidth = 500
    
    // Use a popover i.e. "menubar icon speech bubble" instead of dialogs / windows
    var popover: NSPopover = NSPopover()
    
    // hostingController is used for bridging SwiftUI views into AppKit's NSPopover
    var hostingController: NSHostingController<ContentView>?
    lazy var statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
    @Published var currentView: CurrentView = .restartConfirmation(1)
    var menuItemToView: [NSMenuItem: MenuItem] = [:]
    
    // TODO: refactor this into a separate class (or at least a separate file)?
    // FIXME: UI demo only (code is stupid and ugly, will fix later)
    func setStartupDiskForNextBootOnlyAndRestart() {
        // Synchronous: if mouse cursor on icon, it will beachball until password dialog dismissed (intended behavior)
        // TODO: can this line be removed? (wasn't it closed earlier?)
        self.closePopover(nil)
        
        // TODO: hardcoded for now etc, fix later...
        let script = """
        do shell script "bless --mount \\"/Volumes/FedoraLinux\\" --setBoot --nextonly" with administrator privileges
        """
        let appleScript = NSAppleScript(source: script)
        
        var error: NSDictionary?
        if appleScript?.executeAndReturnError(&error) == nil {
            // TODO: implement better error handling
            // If user canceled, do nothing and return
            if let error = error, (error[NSAppleScript.errorNumber] as? Int) == -128 {
                // Try to close the popover just in case it wasn't already successfully closed earlier
                DispatchQueue.main.async {
                    self.closePopover(nil)
                }
                return
            }
            // TODO: implement the real popover UI for this error message
            // Display an error dialog (show full error message from sudo bless)
            let alert = NSAlert()
            alert.messageText = "Error"
            if let errorMessage = error?[NSAppleScript.errorMessage] as? String {
                alert.informativeText = errorMessage
            } else {
                alert.informativeText = "Unknown error"
            }
            alert.alertStyle = .warning
            alert.runModal()
            return
        } else {
            // DEBUG: Fake restart (dialog only, no actual restart)
            NSAppleScript(source: "display dialog \"Fake restart\"")?.executeAndReturnError(nil)
            // Perform the actual restart
            // NSAppleScript(source: "tell application \"System Events\" to restart")?.executeAndReturnError(nil)
        }
    }
}
