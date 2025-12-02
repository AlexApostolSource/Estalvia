//
//  EspenseList.swift
//  Estalvia
//
//  Created by Alex.personal on 1/12/25.
//

import EstalviaDesignSystem
import SwiftUI

struct ExpenseListView: View {
	private let expenses: [EstalviaExpense]
	private let action: ExpenseListViewSwipeAction

	init(expenses: [EstalviaExpense], action: ExpenseListViewSwipeAction) {
		self.expenses = expenses
		self.action = action
	}

	var body: some View {
		List(expenses) { expense in
			HomeFactory.makeExpenseListView(from: expense).swipeActions {
				Button(role: .destructive) {
					action.destructiveAction(expense)
				} label: {
					Label("Delete", systemImage: "trash.fill")
				}.estalviaTheme(.medium)
			}
		}
	}
}

struct ExpenseListViewSwipeAction {
	let destructiveAction: (EstalviaExpense) -> Void
}
