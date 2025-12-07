//
//  EstalviaMocks.swift
//  Estalvia
//
//  Created by Alex.personal on 7/12/25.
//
@testable import Estalvia
import Foundation

final class MockHomeSaveExpanseUseCase: HomeSaveExpanseUseCaseProtocol {
	var mockError: Error?
	var saveExpenseCallCount = 0
	var saveExpenseWithObjectCallCount = 0
	var savedExpense: EstalviaExpense?
	var savedAmount: String?
	var savedDescription: String?

	func saveExpense(amount: String, description: String) throws {
		if let mockError {
			throw mockError
		}
		saveExpenseCallCount += 1
		savedAmount = amount
		savedDescription = description
	}

	func saveExpense(expense: EstalviaExpense) throws {
		if let mockError {
			throw mockError
		}
		saveExpenseWithObjectCallCount += 1
		savedExpense = expense
	}
}

final class MockGetEspensesUseCase: HomeGetExpenseUseCaseProtocol {
	var mockExpense: [EstalviaExpense] = []
	var mockError: Error?
	var getExpensesCallCount = 0
	func getExpenses() throws -> [Estalvia.EstalviaExpense] {
		getExpensesCallCount += 1
		if let mockError {
			throw mockError
		}
		return mockExpense
	}
}

extension EstalviaExpense {
	static func makeStub(id: String = "", name: String = "", amount: Double = 0, date: Date = .init(), parentId: String? = nil) -> EstalviaExpense {
		 EstalviaExpense(id: id, name: name, amount: amount, date: date, parentId: parentId)
	}
}
