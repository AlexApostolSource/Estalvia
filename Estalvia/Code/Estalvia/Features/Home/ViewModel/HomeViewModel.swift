//
//  HomeViewModel.swift
//  Estalvia
//
//  Created by Alex.personal on 9/11/25.
//

import Combine
import SwiftUI

@Observable
final class HomeViewModel {
	private let useCase: HomeGetExpenseUseCaseProtocol
	private(set) var expenses: [EstalviaExpense] = []

	init(useCase: HomeGetExpenseUseCaseProtocol) {
		self.useCase = useCase
	}

	func getExpenses() {
		do {
			let result = try useCase.getExpenses()
			expenses = result
		} catch {
			print(error)
		}
	}
}
