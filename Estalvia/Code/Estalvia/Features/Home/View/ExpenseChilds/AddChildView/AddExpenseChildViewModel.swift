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
	private let useCase: HomeSaveExpanseUseCaseProtocol
	var amount: String
	var description: String

	init(expense: EstalviaExpense, useCase: HomeSaveExpanseUseCaseProtocol) {
		self.expense = expense
		self.useCase = useCase
		amount = ""
		description = ""
	}

	func addChild() {
		do {
			let child = EstalviaExpense(
				id: UUID().uuidString,
				name: description,
				amount: Double(amount) ?? 0.0,
				date: Date(),
				parentId: expense.id
			)
			try useCase.saveExpense(expense: child)
		} catch {
			print(error)
		}
	}
}
