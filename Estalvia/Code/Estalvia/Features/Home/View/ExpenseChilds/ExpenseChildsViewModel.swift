//
//  ExpenseChildsViewModel.swift
//  Estalvia
//
//  Created by Alex.personal on 1/12/25.
//

import SwiftUI

@Observable
final class ExpenseChildsViewModel {
	private(set) var expense: EstalviaExpense

	init(expense: EstalviaExpense) {
		self.expense = expense
	}
}
