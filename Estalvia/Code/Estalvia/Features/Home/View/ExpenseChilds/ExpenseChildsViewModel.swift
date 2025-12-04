//
//  ExpenseChildsViewModel.swift
//  Estalvia
//
//  Created by Alex.personal on 1/12/25.
//

import SwiftUI

@Observable
final class ExpenseChildsViewModel {
	private(set) var parent: EstalviaExpense
	private let useCase: HomeUpdateExpenseUseCaseProtocol
	private let getExpensesUseCase: HomeGetExpenseUseCaseProtocol
	private let navigationOutput: HomeNavigationOutputs
	private(set) var children: [EstalviaExpense] = []

	init(
		expense: EstalviaExpense,
		useCase: HomeUpdateExpenseUseCaseProtocol,
		getExpensesUseCase: HomeGetExpenseUseCaseProtocol,
		navigationOutput: HomeNavigationOutputs
	) {
		self.parent = expense
		self.useCase = useCase
		self.navigationOutput = navigationOutput
		self.getExpensesUseCase = getExpensesUseCase
	}

	func updateExpense() {
		do {
			try useCase.update(expense: parent)
		} catch {
			print(error)
		}
	}

	func loadChildren() {
		do {
			let all = try getExpensesUseCase.getExpenses()
			children = all.filter { $0.parentId == parent.id }
		} catch {
			print(error)
		}
	}

	func removeChild(child: EstalviaExpense) {
		let filteredChild = children.first(where: { $0.id == child.id })
		guard var filteredChild else { return }
		children.removeAll(where: { $0.id == filteredChild.id })
		filteredChild.parentId = nil
		do {
			try useCase.update(expense: filteredChild)
		} catch {
			print(error)
		}
	}

	func didPressAddChild() {
		navigationOutput.showAddExpenseChild(expense: parent, onSaved: { [weak self] in
			self?.loadChildren()
		})
	}
}
