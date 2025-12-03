//
//  HomeViewModel.swift
//  Estalvia
//
//  Created by Alex.personal on 9/11/25.
//

import Combine
import SwiftUI

@Observable
final class HomeViewModel {
	private let useCase: HomeGetExpenseUseCaseProtocol
	private let deleteExpenseUseCase: HomeDeleteExpenseUseCaseProtocol
	private let navigationOutput: HomeNavigationOutputs

	private(set) var expenses: [EstalviaExpense] = []

	init(
		useCase: HomeGetExpenseUseCaseProtocol,
		deleteExpenseUseCase: HomeDeleteExpenseUseCaseProtocol,
		navigationOutput: HomeNavigationOutputs
	) {
		self.useCase = useCase
		self.deleteExpenseUseCase = deleteExpenseUseCase
		self.navigationOutput = navigationOutput
	}

	func getExpenses() {
		do {
			let result = try useCase.getExpenses()
			expenses = result
		} catch {
			print(error)
		}
	}

	func deleteExpense(_ expense: EstalviaExpense) {
		do {
			try deleteExpenseUseCase.deleteExpense(expense: expense)
			getExpenses()
		} catch {
			print(error)
		}
	}

	func didPressAddExpense(onSaved: (() -> Void)? = nil) {
		navigationOutput.showAddExpense(onSaved: onSaved)
	}

	func didTapExpense(_ expense: EstalviaExpense) {
		navigationOutput.showParentExpenseDetail(expense: expense)
	}
}
