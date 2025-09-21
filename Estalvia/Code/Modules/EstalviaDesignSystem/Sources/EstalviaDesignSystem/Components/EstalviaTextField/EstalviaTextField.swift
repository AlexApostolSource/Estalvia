//
//  EstalviaTextField.swift
//  EstalviaDesignSystem
//
//  Created by Alex.personal on 20/9/25.
//

import SwiftUI

public struct EstalviaTextFieldPreview: View {
    public var body: some View {
        Text("Hello, World!")
    }

    public init () {}
}

#Preview {
    EstalviaTextFieldPreview()
}

public struct EstalviaTextField: TextFieldStyle {
    public func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding()
            .overlay {
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .stroke(Color(UIColor.systemGray4), lineWidth: 2)
            }
    }
}
