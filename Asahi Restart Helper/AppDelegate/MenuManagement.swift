// SPDX-License-Identifier: MIT
// MenuManagement.swift

import Cocoa
import SwiftUI

// After user selects menu item, send disk number
// TODO: Directly send path (for 'bless') and name (to display to the user)? Or send only the path, get name from path?
enum MenuItem {
    case restart(Int)
    case preferences
}

extension AppDelegate {
    // TODO: Implement actually querying the Linux disks, use "diskutil list -plist"
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        if let button = statusItem.button {
            button.image = NSImage(named: "MenuBarIcon")
            // If user clicks icon, open the menu (or close menu/popover if one is already open)
            button.action = #selector(toggleVisibility(_:))
        }
        // Make popovers close if the user clicks elsewhere on the screen
        popover.behavior = .transient
        popover.delegate = self
        
        let menu = NSMenu()
        
        let item1 = NSMenuItem(
            title: NSLocalizedString("RestartConfirmationDialog.OnlyTwoDisks.Linux", comment: ""),
            action: #selector(closeTheMenuAndShowThePopover(_:)),
            keyEquivalent: "")
        menu.addItem(item1)
        menuItemToView[item1] = .restart(1)
        
        let restartString = NSLocalizedString("RestartConfirmationDialog.OnlyTwoDisks.macOS", comment: "")
        // TODO: hard-coded for now...
        let currentDefaultString = NSLocalizedString("RestartConfirmationDialog.CurrentDefault", comment: "")
        let item2 = NSMenuItem(
            title: restartString + " " + currentDefaultString,
            action: #selector(closeTheMenuAndShowThePopover(_:)),
            keyEquivalent: "")
        menu.addItem(item2)
        menuItemToView[item2] = .restart(2)
        
        menu.addItem(NSMenuItem.separator())
        
        let submenu = NSMenu()
        
        // TODO: actually implement
        let diskName = "Fedora Linux"
        let useDiskString = NSLocalizedString("RestartConfirmationDialog.UseDisk", comment: "")
        let newStartupDiskItem = NSMenuItem(
            title: String(format: useDiskString, diskName),
            action: #selector(newStartupDiskSelected(_:)), keyEquivalent: "")
        newStartupDiskItem.tag = 1  // replace with the actual disk number
        submenu.addItem(newStartupDiskItem)
        
        let submenuItem = NSMenuItem(
            title: NSLocalizedString("RestartConfirmationDialog.ChangeStartupDisk", comment: ""),
            action: nil,
            keyEquivalent: "")
        submenuItem.submenu = submenu
        menu.addItem(submenuItem)
        
        menu.addItem(NSMenuItem.separator())
        
        let item3 = NSMenuItem(
            title: NSLocalizedString("RestartConfirmationDialog.Preferences", comment: ""),
            action: #selector(closeTheMenuAndShowThePopover(_:)),
            keyEquivalent: "")
        menu.addItem(item3)
        menuItemToView[item3] = .preferences
        
        statusItem.menu = menu
    }
    
    @objc func closeTheMenuAndShowThePopover(_ sender: NSMenuItem) {
        guard let menuItem = menuItemToView[sender] else {
            return
        }
        
        // Close the menu
        statusItem.menu?.cancelTracking()
        
        // Set the current view based on the menu item
        switch menuItem {
            case .restart(let diskNumber):
                currentView = .restartConfirmation(diskNumber)
            case .preferences:
                currentView = .preferences
        }
        
        // Show the popover
        hostingController = NSHostingController(rootView: ContentView(appDelegate: self))
        popover.contentViewController = hostingController
        if let button = statusItem.button {
            showPopover(button)
        }
    }
    
    // TODO: implement the "real" popover UI
    @objc func newStartupDiskSelected(_ sender: NSMenuItem) {
        let alert = NSAlert()
        alert.messageText = NSLocalizedString("StartupDiskConfirmationDialog.Title", comment: "")
        let diskName = "Fedora Linux"
        let infoText = String(
            format: NSLocalizedString("StartupDiskConfirmationDialog.Info", comment: ""), diskName)
        let explanationText = NSLocalizedString("StartupDiskConfirmationDialog.Explanation", comment: "")
        alert.informativeText = infoText + "\n\n" + explanationText
        alert.alertStyle = .informational
        alert.addButton(withTitle: NSLocalizedString("StartupDiskConfirmationDialog.Change", comment: ""))
        alert.addButton(withTitle: NSLocalizedString("StartupDiskConfirmationDialog.Cancel", comment: ""))
        alert.runModal()
    }
}
