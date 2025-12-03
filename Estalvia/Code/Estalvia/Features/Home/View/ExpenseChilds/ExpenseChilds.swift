//
//  ExpenseChilds.swift
//  Estalvia
//
//  Created by Alex.personal on 1/12/25.
//
import EstalviaDesignSystem
import SwiftUI

struct ExpenseChildsView: View {
	@State var viewModel: ExpenseChildsViewModel

	var body: some View {
		let expenses = viewModel.expense.child ?? []
			VStack {
				ExpenseListView(expenses: expenses, action: ExpenseListViewSwipeAction(destructiveAction: { expense in
					viewModel.removeChild(child: expense)
				}))
				Spacer()
				HStack {
					Spacer(minLength: 0)
					Button("+") {
						viewModel.didPressAddChild()
					}.estalviaPrimaryButton(
						size: .circle,
						color: .estalviaPrimaryGreen
					).frame(maxWidth: 44).padding(.trailing, 24)
				}
			}.padding(.bottom, 16)

	}
}
