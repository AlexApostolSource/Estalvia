//
//  HomeAddExpenseViewModel.swift
//  Estalvia
//
//  Created by Alex.personal on 15/11/25.
//

import Combine
import SwiftUI

@Observable
final class HomeAddExpenseViewModel {
	private let useCase: HomeSaveExpanseUseCaseProtocol
	var amount: String = ""
	var description: String = ""
	var isErrorPresented = false
	var errorTitle: String = ""

	init(useCase: HomeSaveExpanseUseCaseProtocol) {
		self.useCase = useCase
	}

	func saveExpense() -> Bool {
		guard !amount.isEmpty, !description.isEmpty else { return isErrorPresented }
		do {
			try useCase.saveExpense(amount: amount, description: description)
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
