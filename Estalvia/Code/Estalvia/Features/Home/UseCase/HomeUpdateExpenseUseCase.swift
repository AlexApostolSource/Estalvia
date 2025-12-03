//
//  HomeUpdateExpenseUseCase.swift
//  Estalvia
//
//  Created by Alex.personal on 2/12/25.
//

protocol HomeUpdateExpenseUseCaseProtocol {
	func update(expense: EstalviaExpense) throws
}

struct HomeUpdateExpenseUseCase: HomeUpdateExpenseUseCaseProtocol {
	private let repo: HomeRepositoryProtocol

	init(repo: HomeRepositoryProtocol) {
		self.repo = repo
	}

	func update(expense: EstalviaExpense) throws {
		try repo.update(expense: expense)
	}
}
