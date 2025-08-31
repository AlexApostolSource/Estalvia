//
//  EstalviaButton.swift
//  EstalviaDesignSystem
//
//  Created by Alex.personal on 31/8/25.
//

import Foundation
import SwiftUI

public struct EstalviaButton: View {
    public var body: some View {
        Button("Press me!") {
            print("Button tapped!")
        }.buttonStyle(.myAppPrimaryButton)
    }

    public init() {}
}

protocol ButtonStyle: ViewModifier {
    associatedtype Label: View

}

struct PrimaryButtonStyle: SwiftUI.ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(EdgeInsets(top: 5, leading: 15, bottom: 5, trailing: 15))
            .bold()
            .foregroundStyle(.white)
            .background(Color.accentColor)
            .clipShape(Capsule(style: .continuous))
            .scaleEffect(configuration.isPressed ? 0.9 : 1)
            .animation(.smooth, value: configuration.isPressed)
    }
}

extension SwiftUI.ButtonStyle where Self == PrimaryButtonStyle {
    static var myAppPrimaryButton: PrimaryButtonStyle { .init() }
}
