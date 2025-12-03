//
//  AddExpenseChildViewModel.swift
//  Estalvia
//
//  Created by Alex.personal on 2/12/25.
//
import Combine
import SwiftUI

@Observable
final class AddExpenseChildViewModel {
	private var expense: EstalviaExpense
	private let useCase: HomeUpdateExpenseUseCaseProtocol
	var amount: String
	var description: String

	init(expense: EstalviaExpense, useCase: HomeUpdateExpenseUseCaseProtocol) {
		self.expense = expense
		self.useCase = useCase
		amount = ""
		description = ""
		self.expense.child = []

	}

	func addChild() {
		do {
			expense.child?.append(
				EstalviaExpense(
					id: UUID().uuidString,
					name: description,
					amount: Double(amount) ?? 0.0,
					date: Date(),
					child: nil
				)
			)
			try useCase.update(expense: expense)
		} catch {
			print(error)
		}
	}
}
