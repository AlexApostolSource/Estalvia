//
//  ExpenseTransactionListView.swift
//  Estalvia
//
//  Created by Alex.personal on 8/12/25.
//

import EstalviaDesignSystem
import SwiftUI

struct ExpenseTransactionListView: View {
	private let transactions: [EstalviaTransaction]
	private let action: ExpenseTransactionListViewSwipeAction

	init(transactions: [EstalviaTransaction], action: ExpenseTransactionListViewSwipeAction) {
		self.transactions = transactions
		self.action = action
	}

	var body: some View {
		List(transactions) { transaction in
			HomeFactory.makeTransactionListView(transaction: transaction).swipeActions {
				Button(role: .destructive) {
					action.destructiveAction(transaction)
				} label: {
					Label("Delete", systemImage: "trash.fill")
				}.estalviaTheme(.medium)
			}
		}
	}
}

struct ExpenseTransactionListViewSwipeAction {
	let destructiveAction: (EstalviaTransaction) -> Void
}
