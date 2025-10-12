//
//  EstalviaTextField.swift
//  EstalviaDesignSystem
//
//  Created by Alex.personal on 14/9/25.
//

import SwiftUI

public struct EstalviaTextPreview: View {
    public var body: some View {
        VStack {
            Text("Ammount").estalviaTextView(.amountPrimary)
            Text("Caption").estalviaTextView(.caption)
            Text("Subtitle").estalviaTextView(.subtitle)
            Text("Title").estalviaTextView(.title)
        }.padding()
    }

    public init () {}
}

#Preview {
    EstalviaTextPreview()
}

public enum EstalviaTextViewStyle {
    case title
    case subtitle
    case body
    case caption
    case amountPrimary
}

public struct EstalviaText: ViewModifier {
    public let fontSize: CGFloat?
    public let textColor: Color?
    public let type: EstalviaTextViewStyle

    public init(
        fontSize: CGFloat?,
        textColor: Color?,
        type: EstalviaTextViewStyle
    ) {
        self.fontSize = fontSize
        self.textColor = textColor
        self.type = type
    }

    public func body(content: Content) -> some View {
        let color = textColor ?? .estalviaPrimaryBlack
        switch type {
        case .title:
            content
                .foregroundStyle(color)
                .font(.system(size: fontSize ?? 24, weight: .bold))
        case .subtitle:
            content.foregroundStyle(color).font(.system(size: fontSize ?? 14))
        case .body:
            content.foregroundStyle(color).font(.system(size: fontSize ?? 14))
        case .caption:
            content.foregroundStyle(textColor ?? .estalviaPrimaryGray)
                .font(.system(size: fontSize ?? 12))
        case .amountPrimary:
				content.font(.system(size: fontSize ?? 24, weight: .bold)).foregroundStyle(color).monospacedDigit()
                .contentTransition(.numericText())
                .lineLimit(1)
                .minimumScaleFactor(0.85)
        }
    }
}

@MainActor
public extension Text {
    func estalviaTextView(
        _ type: EstalviaTextViewStyle,
        color: Color? = nil,
        fontSize: CGFloat? = nil
    ) -> some View {
        modifier(
            EstalviaText(
                fontSize: fontSize,
                textColor: color,
                type: type
            )
        )
    }
}
