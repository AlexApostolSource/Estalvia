//
//  ExpenseChildsViewModel.swift
//  Estalvia
//
//  Created by Alex.personal on 1/12/25.
//

import SwiftUI

@Observable
final class ExpenseChildsViewModel {
	private(set) var expense: EstalviaExpense
	private let useCase: HomeUpdateExpenseUseCaseProtocol
	private let navigationOutput: HomeNavigationOutputs

	init(
		expense: EstalviaExpense,
		useCase: HomeUpdateExpenseUseCaseProtocol,
		navigationOutput: HomeNavigationOutputs
	) {
		self.expense = expense
		self.useCase = useCase
		self.navigationOutput = navigationOutput
	}

	func updateExpense() {
		do {
			try useCase.update(expense: expense)
		} catch {
			print(error)
		}
	}

	func removeChild(child: EstalviaExpense) {
		expense.child?.removeAll(where: { $0.id == child.id })
	}

	func didPressAddChild() {
		navigationOutput.showAddExpenseChild(expense: expense, onSaved: nil)
	}
}
