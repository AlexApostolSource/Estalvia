//
//  EstalviaButtonStyle.swift
//  EstalviaDesignSystem
//
//  Created by Alex.personal on 14/9/25.
//
import SwiftUI

public struct EstalviaPrimaryButtonStyle: SwiftUI.ButtonStyle {
    @Environment(\.estalviaTheme) private var theme
    @Environment(\.isEnabled) private var isEnabled
    private let size: EstalviaButtonTheme
    private let cornerRadiusOverride: CGFloat?

    public init(size: EstalviaButtonTheme = .medium, cornerRadius: CGFloat? = nil) {
        self.size = size
        self.cornerRadiusOverride = cornerRadius
    }

    public func makeBody(configuration: Configuration) -> some View {
        let radius = cornerRadiusOverride ?? theme.cornerRadius
        return  configuration.label
            .font(size.font)
            .multilineTextAlignment(.center)
            .padding(size.padding)
            .frame(maxWidth: .infinity, minHeight: 44)     // área táctil mínima
            .background(
                RoundedRectangle(cornerRadius: radius)
                    .fill(theme.primaryColor)
            )
            .foregroundStyle(.white)
            .contentShape(RoundedRectangle(cornerRadius: radius)) // hit test
            .opacity(isEnabled ? (configuration.isPressed ? 0.9 : 1) : 0.5)
            .scaleEffect(configuration.isPressed ? 0.98 : 1)
            .animation(.smooth, value: configuration.isPressed) // iOS 17
    }
}


public extension View {
    func estalviaPrimaryButton(size: EstalviaButtonTheme = .medium) -> some View {
        self.buttonStyle(EstalviaPrimaryButtonStyle(size: size))
    }
    func estalviaTheme(_ theme: EstalviaButtonTheme) -> some View {
        self.environment(\.estalviaTheme, theme)
    }
}

public extension SwiftUI.ButtonStyle where Self == EstalviaPrimaryButtonStyle {
    static func estalviaPrimary(size: EstalviaButtonTheme = .medium) -> EstalviaPrimaryButtonStyle {
        EstalviaPrimaryButtonStyle(size: size)
    }
}
