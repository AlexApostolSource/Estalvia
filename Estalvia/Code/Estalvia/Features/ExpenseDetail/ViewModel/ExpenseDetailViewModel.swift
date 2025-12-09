//
//  ExpenseDetailViewModel.swift
//  Estalvia
//
//  Created by Alex.personal on 8/12/25.
//

import SwiftUI

@Observable
final class ExpenseDetailViewModel {
	 let expense: EstalviaExpense

	init(expense: EstalviaExpense) {
		self.expense = expense
	}
}
