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
	private let placeholderAmount: String
	private let placeHolderDescription: String
	private var rightButtonAction: (() -> Void)?
	private var leftButtonAction: (() -> Void)?
	private var autoDismiss: Bool = false
    @Binding private var descriptionBinding: String
    @Binding private var amountText: String
    @Environment(\.dismiss) private var dismiss
    public var body: some View {
        VStack(alignment: .center) {
            Text(titleLabel).estalviaTextView(.title)
            VStack(spacing: 32) {
                EstalviaTextField(
                    title: amountTitle,
					text: $amountText,
					placeholder: "Capital inicial",
					keyboard: .numberPad
				)
                EstalviaTextField(
                    title: description,
                    text: $descriptionBinding,
					placeholder: "Descripción",
                )
            }.padding(EdgeInsets(top: 32, leading: 16, bottom: 0, trailing: 16))

            HStack {
                Button(leftButtonTitle) {
					leftButtonAction?()
					if autoDismiss {
						dismiss()
					}
                }.estalviaPrimaryButton(size: .large, color: .estalviaPrimaryRed)
                Spacer()
                Button(rightButtonTitle) {
					rightButtonAction?()
					if autoDismiss {
						dismiss()
					}
                }.estalviaPrimaryButton(
                    size: .large,
                    color: .estalviaPrimaryBlue
                )
            }.padding(EdgeInsets(top: 32, leading: 16, bottom: 0, trailing: 16))
        }
    }

	public init(
		titleLabel: String,
		amountTitle: String,
		leftButtonTitle: String,
		rightButtonTitle: String,
		amountText: Binding<String>,
		descriptionBinding: Binding<String>,
		description: String,
		placeholderAmount: String,
		placeHolderDescription: String,
		autoDismiss: Bool = false,
		rightButtonAction: (() -> Void)? = nil,
		leftButtonAction: (() -> Void)? = nil
	) {
		self.titleLabel = titleLabel
		self.amountTitle = amountTitle
		self._amountText = amountText
		self._descriptionBinding = descriptionBinding
		self.description = description
		self.leftButtonTitle = leftButtonTitle
		self.rightButtonTitle = rightButtonTitle
		self.placeholderAmount = placeholderAmount
		self.placeHolderDescription = placeHolderDescription
		self.leftButtonAction = leftButtonAction
		self.rightButtonAction = rightButtonAction
		self.autoDismiss = autoDismiss
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
            description: "Description",
			placeholderAmount: "placeholderAmount",
			placeHolderDescription: "placeHolderDescription"
        )
    }

    public init(text: String = "", description: String = "") {
        self.text = text
        self.description = description
    }
}
