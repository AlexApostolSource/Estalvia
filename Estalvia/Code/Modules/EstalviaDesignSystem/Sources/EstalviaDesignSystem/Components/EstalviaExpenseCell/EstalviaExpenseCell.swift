//
//  EstalviaExpenseCell.swift
//  EstalviaDesignSystem
//
//  Created by Alex.personal on 4/10/25.
//

import SwiftUI

public protocol EstalviaExpenseProtocol {
	var format: String { get }
	var color: Color { get }
	var title: String { get }
}

public struct EstalviaExpense: EstalviaExpenseProtocol {
	public var format: String
	public let amount: Decimal
	public var color: Color
	public let symbol: String?
	public var title: String
	private let currencyHelper: CurrencySymbolHelperProtocol = CurrencySymbolHelper()

	init(amount: Decimal, color: Color, symbol: String? = nil, title: String = "Default title") {
		self.format = "\(symbol ?? "")\(amount)\(currencyHelper.symbol())"
		self.amount = amount
		self.symbol = symbol
		self.color = color
		self.title = title
	}
}

public struct EstalviaExpenseCell: View {
	public let image: Image
	public let expenseTitle: String
	public let date: Date
	public let amount: EstalviaExpenseProtocol
	public let initialAmount: EstalviaExpenseProtocol
	public let remainingAmount: EstalviaExpenseProtocol
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
				Text(amount.format).estalviaTextView(.amountPrimary, color: amount.color)
			}.padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
			Divider().frame(height: 1 / UIScreen.main.scale)     .padding(16).foregroundStyle(Color.estalviaPrimaryBlack)
			HStack {
				VStack(alignment: .leading) {
					Text(initialAmount.title).estalviaTextView(.subtitle)
					Text(initialAmount.format).estalviaTextView(.amountPrimary, color: initialAmount.color)
				}
				Spacer()
				VStack(alignment: .trailing) {
					Text(remainingAmount.title).estalviaTextView(.subtitle)
					Text(remainingAmount.format).estalviaTextView(.amountPrimary, color: remainingAmount.color)
				}
			}.padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
		}.padding(EdgeInsets(top: 32, leading: 0, bottom: 32, trailing: 0)).overlay {
			RoundedRectangle(cornerRadius: 16)
				.stroke(Color.estalviaPrimaryGray, lineWidth: 1)
		}
	}
}

public struct EstalviaExpenseCellPreview: View {
	let df: DateFormatter
	public var body: some View {
		EstalviaExpenseCell(
			image: .init(systemName: "house"),
			expenseTitle: "Alquiler",
			date: Date.now,
			amount: EstalviaExpense(
				amount: 2500,
				color: .estalviaPrimaryRed,
				symbol: "-"
			),
			initialAmount: EstalviaExpense(
				amount: 2500,
				color: .estalviaPrimaryBlack,
				title: "Capital antes"
			),
			remainingAmount: EstalviaExpense(
				amount: 2500,
				color: .estalviaPrimaryGreen,
				title: "Capital despues"
			),
			formatter: df
		)
	}

	public init() {
		self.df = DateFormatter()
		df.calendar = .autoupdatingCurrent
		df.locale   = .autoupdatingCurrent
		df.timeZone = .autoupdatingCurrent
		df.dateFormat = "dd MMM, yyyy"
	}
}

#Preview {
	EstalviaExpenseCellPreview()
}
