//
//  EstalviaExpenseCell.swift
//  EstalviaDesignSystem
//
//  Created by Alex.personal on 4/10/25.
//

import SwiftUI

public enum EstalviaExpenseTransactionType {
	case positive
	case negative
	case idle
}

extension EstalviaExpenseTransactionType {
	var color: Color {
		switch self {
		case .positive:
			return Color.estalviaPrimaryGreen
		case .negative:
			return Color.estalviaPrimaryRed
		case .idle:
			return Color.estalviaPrimaryBlack
		}
	}
}

public struct EstalviaExpenseTransactionTypeData {
	public let amount: String
	public var type: EstalviaExpenseTransactionType
	public var title: String

	public init(amount: String, type: EstalviaExpenseTransactionType, title: String = "Default title") {
		self.amount = amount
		self.type = type
		self.title = title
	}
}

public struct EstalviaExpenseCell: View {
	public let image: Image
	public let expenseTitle: String
	public let date: Date
	public let amount: EstalviaExpenseTransactionTypeData
	public let initialAmount: EstalviaExpenseTransactionTypeData
	public let remainingAmount: EstalviaExpenseTransactionTypeData
	public let formatter: DateFormatter
	public var body: some View {
		VStack {
			HStack {
				image.frame(width: 20, height: 20)
				VStack(alignment: .leading) {
					Text(expenseTitle).estalviaTextView(.title)
					Text(formatter.string(from: date)).estalviaTextView(.subtitle)
				}.padding(EdgeInsets(top: 0, leading: 22, bottom: 0, trailing: 0))
				Spacer()
				Text(amount.amount).estalviaTextView(.amountPrimary, color: amount.type.color)
			}.padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
			Divider().frame(height: 1 / UIScreen.main.scale).padding(16).foregroundStyle(Color.estalviaPrimaryBlack)
			HStack {
				VStack(alignment: .leading) {
					Text(initialAmount.title).estalviaTextView(.subtitle)
					Text("\(initialAmount.amount)").estalviaTextView(.amountPrimary, color: amount.type.color)
				}
				Spacer()
				VStack(alignment: .trailing) {
					Text(remainingAmount.title).estalviaTextView(.subtitle)
					Text("\(remainingAmount.amount)").estalviaTextView(.amountPrimary, color: amount.type.color)
				}
			}.padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
		}.padding(EdgeInsets(top: 32, leading: 0, bottom: 32, trailing: 0)).overlay {
			RoundedRectangle(cornerRadius: 16)
				.stroke(Color.estalviaPrimaryGray, lineWidth: 1)
		}
	}

	public init(
		image: Image,
		expenseTitle: String,
		date: Date,
		amount: EstalviaExpenseTransactionTypeData,
		initialAmount: EstalviaExpenseTransactionTypeData,
		remainingAmount: EstalviaExpenseTransactionTypeData,
		formatter: DateFormatter
	) {
		self.image = image
		self.expenseTitle = expenseTitle
		self.date = date
		self.amount = amount
		self.initialAmount = initialAmount
		self.remainingAmount = remainingAmount
		self.formatter = formatter
	}
}

public struct EstalviaExpenseCellPreview: View {
	let dateFormatter: DateFormatter
	public var body: some View {
		EstalviaExpenseCell(
			image: .init(systemName: "house"),
			expenseTitle: "Alquiler",
			date: Date.now,
			amount: EstalviaExpenseTransactionTypeData(
				amount: EstalviaNumberFormatter.format(2500000),
				type: .negative
			),
			initialAmount: EstalviaExpenseTransactionTypeData(
				amount: EstalviaNumberFormatter.format(-2500),
				type: .idle,
				title: "Capital antes"
			),
			remainingAmount: EstalviaExpenseTransactionTypeData(
				amount: EstalviaNumberFormatter.format(2500),
				type: .positive,
				title: "Capital despues"
			),
			formatter: dateFormatter
		)
	}

	public init() {
		self.dateFormatter = .custom()
	}
}

#Preview {
	EstalviaExpenseCellPreview()
}
