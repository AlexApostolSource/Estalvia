//
//  ExpenseChilds.swift
//  Estalvia
//
//  Created by Alex.personal on 1/12/25.
//
import EstalviaDesignSystem
import SwiftUI

struct ExpenseChilds: View {
	@State var viewModel: ExpenseChildsViewModel

	var body: some View {
		if let expense = viewModel.expense.child {
			ExpenseListView(expenses: expense, action: ExpenseListViewSwipeAction(destructiveAction: { _ in

			}))
		}
	}
}
