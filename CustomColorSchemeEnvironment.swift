//
//  CustomColorSchemeEnvironment.swift
//  LiveFind
//
//  Created by keckuser on 11/15/23.
//

import SwiftUI

// Define your custom color scheme enum
enum CustomColorScheme {
    case standard
    case custom // You can add more cases if needed

    // Computed properties to return the appropriate colors
    var primaryColor: Color {
        switch self {
        case .standard:
            return Color("DefaultPrimary") // Adjust as needed
        case .custom:
            return Color("PrimaryColor")
        }
    }

    var accentColor: Color {
        switch self {
        case .standard:
            return Color("DefaultAccent") // Adjust as needed
        case .custom:
            return Color("SecondaryColor")
        }
    }
}

// Define the custom environment key
struct CustomColorSchemeKey: EnvironmentKey {
    static let defaultValue: CustomColorScheme = .standard // Set the default value
}

// Extend EnvironmentValues to include your custom color scheme
extension EnvironmentValues {
    var customColorScheme: CustomColorScheme {
        get { self[CustomColorSchemeKey.self] }
        set { self[CustomColorSchemeKey.self] = newValue }
    }
}
