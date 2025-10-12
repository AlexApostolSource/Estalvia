//
//  EstalviaExpenseCell.swift
//  EstalviaDesignSystem
//
//  Created by Alex.personal on 4/10/25.
//

import SwiftUI

public protocol EstalviaExpenseProtocol {
	var color: Color { get }
	var title: String { get }
	var amount: String { get }
}

public struct EstalviaExpense: EstalviaExpenseProtocol {
	public let amount: String
	public var color: Color
	public var title: String

	init(amount: String, color: Color, title: String = "Default title") {
		self.amount = amount
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
				Text(amount.amount).estalviaTextView(.amountPrimary, color: amount.color)
			}.padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
			Divider().frame(height: 1 / UIScreen.main.scale).padding(16).foregroundStyle(Color.estalviaPrimaryBlack)
			HStack {
				VStack(alignment: .leading) {
					Text(initialAmount.title).estalviaTextView(.subtitle)
					Text("\(initialAmount.amount)").estalviaTextView(.amountPrimary, color: initialAmount.color)
				}
				Spacer()
				VStack(alignment: .trailing) {
					Text(remainingAmount.title).estalviaTextView(.subtitle)
					Text("\(remainingAmount.amount)").estalviaTextView(.amountPrimary, color: remainingAmount.color)
				}
			}.padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
		}.padding(EdgeInsets(top: 32, leading: 0, bottom: 32, trailing: 0)).overlay {
			RoundedRectangle(cornerRadius: 16)
				.stroke(Color.estalviaPrimaryGray, lineWidth: 1)
		}
	}
}

public struct EstalviaExpenseCellPreview: View {
	let dateFormatter: DateFormatter
	public var body: some View {
		EstalviaExpenseCell(
			image: .init(systemName: "house"),
			expenseTitle: "Alquiler",
			date: Date.now,
			amount: EstalviaExpense(
				amount: EstalviaNumberFormatter.format(2500000),
				color: .estalviaPrimaryRed
			),
			initialAmount: EstalviaExpense(
				amount: EstalviaNumberFormatter.format(-2500),
				color: .estalviaPrimaryBlack,
				title: "Capital antes"
			),
			remainingAmount: EstalviaExpense(
				amount: EstalviaNumberFormatter.format(2500),
				color: .estalviaPrimaryGreen,
				title: "Capital despues"
			),
			formatter: dateFormatter
		)
	}

	public init() {
		self.dateFormatter = DateFormatter()
		dateFormatter.calendar = .autoupdatingCurrent
		dateFormatter.locale   = .autoupdatingCurrent
		dateFormatter.timeZone = .autoupdatingCurrent
		dateFormatter.dateFormat = "dd MMM, yyyy"
	}
}

#Preview {
	EstalviaExpenseCellPreview()
}
