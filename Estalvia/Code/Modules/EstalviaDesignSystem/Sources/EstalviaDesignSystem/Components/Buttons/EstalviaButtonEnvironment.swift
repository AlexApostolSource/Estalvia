//
//  EstalviaButtonEnvironment.swift
//  EstalviaDesignSystem
//
//  Created by Alex.personal on 14/9/25.
//
import SwiftUI

private struct EstalviaThemeKey: EnvironmentKey {
	static let defaultValue = EstalviaButtonTheme()
    init() {}
}


public extension EnvironmentValues {
    var estalviaTheme: EstalviaButtonTheme {
        get { self[EstalviaThemeKey.self] }
        set { self[EstalviaThemeKey.self] = newValue }
    }
}
