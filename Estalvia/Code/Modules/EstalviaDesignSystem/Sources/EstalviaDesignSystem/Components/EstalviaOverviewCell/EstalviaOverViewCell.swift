//
//  EstalviaOverViewCell.swift
//  EstalviaDesignSystem
//
//  Created by Alex.personal on 27/9/25.
//

import SwiftUI

public struct EstalviaOverViewCellConfig {
	public let titleLabel: String
	public let subtitleLabel: String
	public let initialAmount: String
	public let remainingAmount: String
	public var onEditInitial: @MainActor () -> Void
	public var onEditActual: @MainActor () -> Void

	public init(
		titleLabel: String,
		subtitleLabel: String,
		initialAmount: String,
		remainingAmount: String,
		onEditInitial: @escaping @MainActor () -> Void = {},
		onEditActual: @escaping @MainActor () -> Void = {}
	) {
		self.titleLabel = titleLabel
		self.subtitleLabel = subtitleLabel
		self.initialAmount = initialAmount
		self.remainingAmount = remainingAmount
		self.onEditInitial = onEditInitial
		self.onEditActual  = onEditActual
	}
}

public struct EstalviaOverViewCell: View {
	private let config: EstalviaOverViewCellConfig

    public var body: some View {
        VStack(alignment: .leading) {
            HStack {
                VStack(alignment: .leading) {
					Text(
						config.titleLabel
					).estalviaTextView(.subtitle)
					Text(
						config.initialAmount)
                        .estalviaTextView(.amountPrimary).bold()
                }
                Spacer()
				Button {
					config.onEditInitial()
				} label: {
					Image(systemName: "pencil")
						.resizable()
						.scaledToFit()
						.frame(width: 20, height: 20)
						.foregroundStyle(Color.estalviaPrimaryBlack)
				}

            }
            HStack {
                VStack(alignment: .leading) {
					Text(config.subtitleLabel).estalviaTextView(.subtitle)
					Text(config.remainingAmount)
                        .estalviaTextView(.amountPrimary).bold()
                }
                Spacer()
				Button {
					config.onEditActual()
				} label: {
					Image(systemName: "pencil")
						.resizable()
						.scaledToFit()
						.frame(width: 20, height: 20)
						.foregroundStyle(Color.estalviaPrimaryBlack)
				}
			}.padding(EdgeInsets(top: 16, leading: 0, bottom: 0, trailing: 0))

		}.padding(
			EdgeInsets(
				top: 32,
				leading: 24,
				bottom: 32,
				trailing: 24
			)
		).glassEffect(
			.regular.tint(.estalviaSecondaryBlue).interactive(),
			in: RoundedRectangle(cornerRadius: 16)
		)

    }

	public init(config: EstalviaOverViewCellConfig) {
		self.config = config
	}
}

public struct EstalviaOverViewCellPreview: View {
    public var body: some View {
		EstalviaOverViewCell(
			config: EstalviaOverViewCellConfig(
			titleLabel: "Capital inicial",
			subtitleLabel: "Saldo Actual",
			initialAmount: EstalviaNumberFormatter.format(2500),
			remainingAmount: EstalviaNumberFormatter.format(2500), onEditInitial: {
				print("initial amount")
			}) {
				print("actual amount")
			})
    }

    public init() {}
}

#Preview {
    EstalviaOverViewCellPreview()
}
