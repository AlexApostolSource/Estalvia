//
//  EstalviaButton.swift
//  EstalviaDesignSystem
//
//  Created by Alex.personal on 31/8/25.
//

import Foundation
import SwiftUI

public struct EstalviaButtonView: View {
    public var body: some View {
        HStack {
            Button("Press me!") {
            print("Button tapped!")
        }.estalviaPrimaryButton(size: .large)
            Button("Press me!") {
                print("Button tapped!")
            }.estalviaPrimaryButton(size: .medium)

            Button("Press me!") {
                print("Button tapped!")
            }.estalviaPrimaryButton(size: .small)
        }.padding()

    }

    public init() {}
}

// 1) Tema con tokens
public struct EstalviaTheme {
    // Radios por tamaño  👇
    public var cornerRadiusSmall: CGFloat = 6
    public var cornerRadiusMedium: CGFloat = 8
    public var cornerRadiusLarge: CGFloat = 10

    public var primaryColor: Color = .estalviaPrimaryBlue
    public init() {}

    // Helper para consultar por size  👇
    public func cornerRadius(for size: EstalviaButtonSize) -> CGFloat {
        switch size {
        case .small:  return cornerRadiusSmall
        case .medium: return cornerRadiusMedium
        case .large:  return cornerRadiusLarge
        }
    }
}

private struct EstalviaThemeKey: EnvironmentKey {
    static let defaultValue = EstalviaTheme()
}
public extension EnvironmentValues {
    var estalviaTheme: EstalviaTheme {
        get { self[EstalviaThemeKey.self] }
        set { self[EstalviaThemeKey.self] = newValue }
    }
}

// 2) Tamaños opcionales
public enum EstalviaButtonSize {
    case small, medium, large
    var padding: EdgeInsets {
        switch self {
        case .small:  return .init(top: 10, leading: 12, bottom: 10, trailing: 12)
        case .medium: return .init(top: 15, leading: 16, bottom: 15, trailing: 16)
        case .large:  return .init(top: 18, leading: 20, bottom: 18, trailing: 20)
        }
    }
    var font: Font {
        switch self {
        case .small:
            return .system(size: 12).bold()
        case .medium:
            return .system(size: 14, weight: .bold)
        case .large:
            return .system(size: 16, weight: .bold)
        }
    }
}

// 3) Strategy: estilo del botón
public struct EstalviaPrimaryButtonStyle: SwiftUI.ButtonStyle {
    @Environment(\.estalviaTheme) private var theme
    @Environment(\.isEnabled) private var isEnabled
    private let size: EstalviaButtonSize
    private let cornerRadiusOverride: CGFloat?

    public init(size: EstalviaButtonSize = .medium, cornerRadius: CGFloat? = nil) {
        self.size = size
        self.cornerRadiusOverride = cornerRadius
    }

    public func makeBody(configuration: Configuration) -> some View {
        let radius = cornerRadiusOverride ?? theme.cornerRadius(for: size)
        return  configuration.label
            .font(size.font)
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

// 4) Decorator: modificadores cómodos
public extension View {
    func estalviaPrimaryButton(size: EstalviaButtonSize = .medium) -> some View {
        self.buttonStyle(EstalviaPrimaryButtonStyle(size: size))
    }
    func estalviaTheme(_ theme: EstalviaTheme) -> some View {
        self.environment(\.estalviaTheme, theme)
    }
}

public extension SwiftUI.ButtonStyle where Self == EstalviaPrimaryButtonStyle {
    static func estalviaPrimary(size: EstalviaButtonSize = .medium) -> EstalviaPrimaryButtonStyle {
        EstalviaPrimaryButtonStyle(size: size)
    }
}

#Preview {
    EstalviaButtonView()
}
