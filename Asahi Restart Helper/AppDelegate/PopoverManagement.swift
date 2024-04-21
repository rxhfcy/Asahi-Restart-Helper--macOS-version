// SPDX-License-Identifier: MIT
// PopoverManagement.swift

import Cocoa
import SwiftUI

extension AppDelegate {

    // Display the popover
    @objc func showPopover(_ sender: AnyObject?) {
        if let button = statusItem.button {
            let screenRect = NSScreen.main?.visibleFrame ?? NSRect.zero
            let buttonRect = button.window?.convertToScreen(button.frame) ?? NSRect.zero
            
            // TODO: is it really necessary to duplicate fetching widths here?
            // ...or is it possible to somehow use frame width directly? (see ContentView.swift)
            
            // Fetch "localized" popover width from Localizable.strings, or use fallback value if fetching fails
            var popoverWidth: CGFloat
            switch currentView {
                case .restartConfirmation:
                    popoverWidth = CGFloat(
                        NumberFormatter()
                            .number(from: NSLocalizedString("RestartConfirmationDialog.Width", comment: ""))?
                            .floatValue ?? Float(AppDelegate.fallbackRestartConfirmationPopoverWidth))
                case .preferences:
                    popoverWidth = CGFloat(
                        NumberFormatter()
                            .number(from: NSLocalizedString("PreferencesDialog.Width", comment: ""))?
                            .floatValue ?? Float(AppDelegate.fallbackPreferencesPopoverWidth))
                case .help:
                    popoverWidth = CGFloat(
                        NumberFormatter()
                            .number(from: NSLocalizedString("HelpDialog.Width", comment: ""))?
                            .floatValue ?? Float(AppDelegate.fallbackHelpPopoverWidth))
            }
            
            popover.contentViewController = hostingController
            popover.contentSize = NSSize(width: popoverWidth, height: popover.contentSize.height)
            
            // Adjust horizontal position if the popover wouldn't fit on the screen (menu bar icon too close to edge)
            if buttonRect.origin.x + popoverWidth > screenRect.origin.x + screenRect.width {
                popover.show(
                    relativeTo: NSRect(
                        x: button.bounds.width - popoverWidth,
                        y: button.bounds.height, width: 0, height: 0),
                    of: button, preferredEdge: .minY)
            } else {
                popover.show(relativeTo: button.bounds, of: button, preferredEdge: .minY)
            }
        }
    }

    // Show or hide popover/menu (when user clicks the menubar icon, show/hide)
    @objc func toggleVisibility(_ sender: AnyObject?) {
        if popover.isShown {
            closePopover(sender)
        } else {
            hostingController = NSHostingController(rootView: ContentView(appDelegate: self))
            popover.contentViewController = hostingController
            showPopover(sender)
        }
    }
    
    // Close the popover
    func closePopover(_ sender: AnyObject?) {
        popover.performClose(sender)
    }
}
