//
//  AddExpenseChildValidationUseCase.swift
//  Estalvia
//
//  Created by Alex.personal on 7/12/25.
//

protocol AddExpenseChildValidationUseCaseProtocol {
	func canAddChildExpense(
		parent: EstalviaExpense,
		children: [EstalviaExpense],
		child: EstalviaExpense
	) throws
}

struct AddExpenseChildValidationUseCase: AddExpenseChildValidationUseCaseProtocol {
	func canAddChildExpense(
		parent: EstalviaExpense,
		children: [EstalviaExpense],
		child: EstalviaExpense
	) throws {
		let totalAmount = children.reduce(0) { $0 + $1.amount }
		guard totalAmount + child.amount <= parent.amount else {
			throw AddExpenseChildValidationUseCaseError.invalidAmount(childsAmount: totalAmount, currentChildAmount: child.amount)
		}
	}
}

enum AddExpenseChildValidationUseCaseError: Error {
	case invalidAmount(childsAmount: Double, currentChildAmount: Double)
}
