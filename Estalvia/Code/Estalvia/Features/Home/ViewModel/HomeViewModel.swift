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

	private(set) var expenses: [EstalviaExpense] = []

	init(
		useCase: HomeGetExpenseUseCaseProtocol,
		deleteExpenseUseCase: HomeDeleteExpenseUseCaseProtocol
	) {
		self.useCase = useCase
		self.deleteExpenseUseCase = deleteExpenseUseCase
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
}
