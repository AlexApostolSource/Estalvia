//
//  HomeAddExpenseViewModel.swift
//  Estalvia
//
//  Created by Alex.personal on 15/11/25.
//

import Combine
import SwiftUI

final class HomeAddExpenseViewModel: ObservableObject {
	private let useCase: HomeSaveExpanseUseCaseProtocol
	@Published var amount: String = ""
	@Published var description: String = ""

	init(useCase: HomeSaveExpanseUseCaseProtocol) {
		self.useCase = useCase
	}

	func saveExpense() {
		guard !amount.isEmpty, !description.isEmpty else { return }
		useCase.saveExpense(amount: amount, description: description)
	}
}
