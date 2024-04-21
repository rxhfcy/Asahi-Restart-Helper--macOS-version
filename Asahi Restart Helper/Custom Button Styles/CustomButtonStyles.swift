// SPDX-License-Identifier: MIT
// CustomButtonStyles.swift

import SwiftUI

// Custom button styles ("AccentColor" and "Normal")

// Custom "accent color button" needed, because there is no non-hacky way to look like the system "Restart" button (?)
// - Tiny detail, dark theme only: button background color lighter than "real" accentColor, same problem w/ popovers
struct CustomAccentColorButtonStyle: ButtonStyle {
    @Environment(\.colorScheme) private var colorScheme
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.white)
        // Tiny detail: make padding after button text slightly smaller, looks better this way?
            .padding(EdgeInsets(top: 2, leading: 11, bottom: 3, trailing: 9))
            .background(Color.accentColor)
            .brightness(
                colorScheme == .light
                ? (configuration.isPressed ? -0.1 : 0) : (configuration.isPressed ? 0.1 : 0)
            )
            .clipShape(RoundedRectangle(cornerRadius: 5))
        // NOTE: Does this look better or worse with a very slight shadow? (compare to native Restart dialog)
        // TODO: Also, test the idea to artificially "move" the shadow slightly to down and right to mimic "native"
            .shadow(color: Color.black.opacity(0.05), radius: 0.5, x: 0.5, y: 0.5)
    }
}

// Custom "normal button" also needed, because the custom "accent color button" makes native buttons look out of place
struct CustomNormalButtonStyle: ButtonStyle {
    @Environment(\.colorScheme) private var colorScheme
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(colorScheme == .light ? .black : .white)
        // Tiny detail: make padding after button text slightly smaller, looks better this way?
            .padding(EdgeInsets(top: 2, leading: 11, bottom: 3, trailing: 10))
            .background(
                colorScheme == .light
                ? (configuration.isPressed ? Color.gray.opacity(0.1) : Color.white)
                : (configuration.isPressed ? Color(NSColor.gray).opacity(0.7) : Color(NSColor.darkGray))
            )
            .clipShape(RoundedRectangle(cornerRadius: 5))
        // Add a border if using the light theme, makes it look better
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(colorScheme == .light ? Color.gray.opacity(0.3) : Color.clear, lineWidth: 1)
            )
        // NOTE: Does this look better or worse with a very slight shadow? (compare to native Restart dialog)
        // TODO: Also, test the idea to artificially "move" the shadow slightly to the right and down to mimic "native"
            .shadow(color: Color.black.opacity(0.05), radius: 0.5, x: 0.5, y: 0.5)
    }
}
