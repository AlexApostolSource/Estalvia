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
            Button("Primary Button!") {
                print("Primary Button tapped!")
            }.estalviaPrimaryButton(size: .large, color: .estalviaPrimaryRed)
            Button("Medium Button!") {
                print("Medium Button tapped!")
            }.estalviaPrimaryButton(size: .medium)

            Button("Small Button!") {
                print("Small Button tapped!")
            }.estalviaPrimaryButton(size: .small, color: .estalviaPrimaryGreen)
        }.padding()

    }

    public init() {}
}

#Preview {
    EstalviaButtonView()
}
