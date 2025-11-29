//
//  HomeDeleteExpenseUseCase.swift
//  Estalvia
//
//  Created by Alex.personal on 23/11/25.
//

protocol HomeDeleteExpenseUseCaseProtocol {
	func deleteExpense(expense: EstalviaExpense) throws
}

struct HomeDeleteExpenseUseCase: HomeDeleteExpenseUseCaseProtocol {
	private let repository: HomeRepositoryProtocol

	init(repository: HomeRepositoryProtocol) {
		self.repository = repository
	}

	func deleteExpense(expense: EstalviaExpense) throws {
		try repository.deleteExpense(expense: expense)
	}
}
