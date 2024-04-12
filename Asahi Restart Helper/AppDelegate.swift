// AppDelegate.swift

import AppKit

class AppDelegate: NSObject, NSApplicationDelegate {
    let menuBarManager = MenuBarManager()
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        menuBarManager.setupStatusItem()
    }
}

class MenuBarManager: NSObject {
    var statusItem: NSStatusItem?
    
    override init() {
        super.init()
        DispatchQueue.main.async {
            self.setupStatusItem()
        }
    }
    
    func setupStatusItem() {
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        statusItem?.button?.image = NSImage(named: NSImage.Name("MenuBarIcon"))
        
        let menu = NSMenu()
        menu.addItem(NSMenuItem(title: "Test", action: #selector(testAction), keyEquivalent: ""))
        statusItem?.menu = menu
    }
    
    @objc func testAction() {
        print("Test action triggered")
    }
}
