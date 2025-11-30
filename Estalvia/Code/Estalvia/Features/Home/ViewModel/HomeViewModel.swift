//
//  HomeViewModel.swift
//  Estalvia
//
//  Created by Alex.personal on 9/11/25.
//

import Combine
import SwiftUI

@Observable
final class HomeViewModel<Coordinator: EstalviaNavigationCoordinatorProtocol>
where Coordinator.State == HomeCoordinator.State {
	private let useCase: HomeGetExpenseUseCaseProtocol
	private let deleteExpenseUseCase: HomeDeleteExpenseUseCaseProtocol
	private let coordinator: Coordinator

	private(set) var expenses: [EstalviaExpense] = []

	init(
		useCase: HomeGetExpenseUseCaseProtocol,
		deleteExpenseUseCase: HomeDeleteExpenseUseCaseProtocol,
		coordinator: Coordinator
	) {
		self.useCase = useCase
		self.deleteExpenseUseCase = deleteExpenseUseCase
		self.coordinator = coordinator
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
		coordinator.loop(to: .showAddExpenseView(onSaved: onSaved))
	}
}
