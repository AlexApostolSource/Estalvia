//
//  HomeGetExpenseUseCase.swift
//  Estalvia
//
//  Created by Alex.personal on 23/11/25.
//

protocol HomeGetExpenseUseCaseProtocol {
	func getExpenses() throws -> [EstalviaExpense]
}

struct HomeGetExpenseUseCase: HomeGetExpenseUseCaseProtocol {
	private let repository: HomeRepositoryProtocol

	init(repository: HomeRepositoryProtocol) {
		self.repository = repository
	}

	func getExpenses() throws -> [EstalviaExpense] {
		try repository.getExpenses()
	}
}
