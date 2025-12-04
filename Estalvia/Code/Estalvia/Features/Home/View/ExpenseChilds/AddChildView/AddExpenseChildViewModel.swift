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
	var amount: String
	var description: String
	var isErrorPresented = false
	var errorTitle: String = ""

	init(expense: EstalviaExpense, useCase: HomeSaveExpanseUseCaseProtocol) {
		self.expense = expense
		self.useCase = useCase
		amount = ""
		description = ""
	}

	func addChild() -> Bool {
		let child = EstalviaExpense(
			id: UUID().uuidString,
			name: description,
			amount: Double(amount) ?? 0.0,
			date: Date(),
			parentId: expense.id
		)
		do {
			try useCase.saveExpense(expense: child)
			return isErrorPresented
		} catch let error as HomeRepositoryError {
			switch error {
			case .invalidAmount:
				errorTitle = "La cantidad insertad no es valida"
				isErrorPresented = true
			}
		} catch {
			errorTitle = "Error desconocido vuelva a intentarlo"
			isErrorPresented = true
		}
		return isErrorPresented
	}
}
