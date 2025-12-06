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
	private let getExpensesUseCase: HomeGetExpenseUseCaseProtocol
	private let children: [EstalviaExpense]
	var amount: String
	var description: String
	var isErrorPresented = false
	var errorTitle: String = ""

	init(expense: EstalviaExpense, useCase: HomeSaveExpanseUseCaseProtocol, getExpensesUseCase: HomeGetExpenseUseCaseProtocol, children: [EstalviaExpense]) {
		self.expense = expense
		self.useCase = useCase
		self.getExpensesUseCase = getExpensesUseCase
		self.children = children
		amount = ""
		description = ""
	}

	func addChild() -> Bool {
		let amount = Double(amount) ?? 0.0
		let child = EstalviaExpense(
			id: UUID().uuidString,
			name: description,
			amount: amount,
			date: Date(),
			parentId: expense.id
		)
		do {
			try canAdd(child: child)
			try useCase.saveExpense(expense: child)
			return isErrorPresented
		} catch let error as HomeRepositoryError {
			switch error {
			case .invalidAmount:
				errorTitle = "La cantidad insertad no es valida"
				isErrorPresented = true
			}
		} catch let error as AddExpenseViewModelError {
			switch error {
			case .invalidAmount(let totalAmount, let childAmount):
				errorTitle = "La cantidad total de los hijos: \(totalAmount) y el hijo actual: \(childAmount)no puede superar a la cantidad del padre: \(expense.amount)"
				isErrorPresented = true
			}
		} catch {
			errorTitle = "Error desconocido vuelva a intentarlo"
			isErrorPresented = true
		}
		return isErrorPresented
	}

	private func canAdd(child: EstalviaExpense) throws {
		let totalAmount = children.reduce(0) { $0 + $1.amount }
		guard totalAmount + child.amount <= expense.amount else {
			throw AddExpenseViewModelError.invalidAmount(childsAmount: totalAmount, currentChildAmount: child.amount)
		}
	}
}

enum AddExpenseViewModelError: Error {
	case invalidAmount(childsAmount: Double, currentChildAmount: Double)
}
