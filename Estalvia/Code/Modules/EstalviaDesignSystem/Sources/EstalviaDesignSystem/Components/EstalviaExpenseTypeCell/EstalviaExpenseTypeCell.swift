//
//  EstalviaExpenseTypeCell.swift
//  EstalviaDesignSystem
//
//  Created by Alex.personal on 11/10/25.
//

import SwiftUI

public struct EstalviaExpenseTypeCellConfig {
	public let title: String
	public let amount: String
	public let description: String
	public let tapAction: (() -> Void)?
	let currencyHelper = CurrencySymbolHelper.symbol()

	public init(title: String, amount: String, description: String, tapAction: (() -> Void)? = nil) {
		self.title = title
		self.amount = amount
		self.description = description
		self.tapAction = tapAction
	}
}

public struct EstalviaExpenseTypeCell: View {
	private let config: EstalviaExpenseTypeCellConfig
	public var body: some View {
		HStack {
			VStack(alignment: .leading, spacing: 5) {
				Text(config.title).estalviaTextView(.title, fontSize: 14)
				Text("\(config.amount)").estalviaTextView(.amountPrimary, fontSize: 30).bold()
				Text(config.description).estalviaTextView(.caption).padding(EdgeInsets(top: 4, leading: 0, bottom: 0, trailing: 0))
			}
			Spacer()
		}.padding(EdgeInsets(top: 22, leading: 20, bottom: 22, trailing: 0))
			.glassEffect(
				.regular.tint(Color.estalviaSecondaryBlue).interactive(),
			in: RoundedRectangle(cornerRadius: 16)
			).contentShape(RoundedRectangle(cornerRadius: 16)).onTapGesture {
				config.tapAction?()
			}
	}

	public init(config: EstalviaExpenseTypeCellConfig) {
		self.config = config
	}
}

public struct EstalviaExpenseTypeCellPreview: View {
	public var body: some View {
		EstalviaExpenseTypeCell(
			config: EstalviaExpenseTypeCellConfig(
				title: "Gasto Personal",
				amount: EstalviaNumberFormatter.format(11250),
				description: "Saldo disponible"
			)
		)
	}

	public init() {}
}

#Preview {
	EstalviaExpenseTypeCellPreview()
}
