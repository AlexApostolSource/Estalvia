//
//  ExpenseDetail.swift
//  Estalvia
//
//  Created by Alex.personal on 8/12/25.
//

import EstalviaDesignSystem
import SwiftUI

struct ExpenseDetail: View {
	@State var viewModel: ExpenseDetailViewModel
	var body: some View {
		ExpenseTransactionListView(
			transactions: viewModel.expense.transactions,
			action: ExpenseTransactionListViewSwipeAction(
				destructiveAction: { _ in
				})
		)
	}
}
