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
    @Binding private var descriptionBinding: String
    @Binding private var amountText: String
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
                Button("Cancelar") {

                }.estalviaPrimaryButton(size: .large, color: .estalviaPrimaryRed)
                Spacer()
                Button("Acceptar") {

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
        amountText: Binding<String>,
        descriptionBinding: Binding<String>,
        description: String
    ) {
        self.titleLabel = titleLabel
        self.amountTitle = amountTitle
        self._amountText = amountText
        self._descriptionBinding = descriptionBinding
        self.description = description
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
            amountText: $text,
            descriptionBinding: $description,
            description: "Description"

        )
    }
}
