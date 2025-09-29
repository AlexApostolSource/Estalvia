//
//  EstalviaAmountModal.swift
//  EstalviaDesignSystem
//
//  Created by Alex.personal on 28/9/25.
//

import SwiftUI

public struct EstalviaAmountModal: View {
    private let titleLabel: String
    private let amountTitle: String
    private let description: String
    private let leftButtonTitle: String
    private let rightButtonTitle: String
    @Binding private var descriptionBinding: String
    @Binding private var amountText: String
    @Environment(\.dismiss) private var dismiss
    public var body: some View {
        VStack(alignment: .center) {
            Text(titleLabel).estalviaTextView(.title)
            VStack(spacing: 32) {
                EstalviaTextField(
                    title: amountTitle,
                    text: $amountText
                )
                EstalviaTextField(
                    title: description,
                    text: $descriptionBinding
                )
            }.padding(EdgeInsets(top: 32, leading: 16, bottom: 0, trailing: 16))

            HStack {
                Button(leftButtonTitle) {
                    dismiss()
                }.estalviaPrimaryButton(size: .large, color: .estalviaPrimaryRed)
                Spacer()
                Button(rightButtonTitle) {
                    dismiss()
                }.estalviaPrimaryButton(
                    size: .large,
                    color: .estalviaPrimaryBlue
                )
            }.padding(EdgeInsets(top: 32, leading: 16, bottom: 0, trailing: 16))
        }
    }

    init(
        titleLabel: String,
        amountTitle: String,
        leftButtonTitle: String,
        rightButtonTitle: String,
        amountText: Binding<String>,
        descriptionBinding: Binding<String>,
        description: String
    ) {
        self.titleLabel = titleLabel
        self.amountTitle = amountTitle
        self._amountText = amountText
        self._descriptionBinding = descriptionBinding
        self.description = description
        self.leftButtonTitle = leftButtonTitle
        self.rightButtonTitle = rightButtonTitle
    }
}

#Preview {
    EstalviaAmountModalPreview()
}

public struct EstalviaAmountModalPreview: View {
    @State private var text = ""
    @State private var description = ""

    public var body: some View {
        EstalviaAmountModal(
            titleLabel: "Title",
            amountTitle: "Importe",
            leftButtonTitle: "Cancelar",
            rightButtonTitle: "Acceptar",
            amountText: $text,
            descriptionBinding: $description,
            description: "Description"

        )
    }

    public init(text: String = "", description: String = "") {
        self.text = text
        self.description = description
    }
}
