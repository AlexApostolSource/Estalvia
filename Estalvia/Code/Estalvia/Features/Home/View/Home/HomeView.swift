//
//  HomeView.swift
//  Estalvia
//
//  Created by Alex.personal on 9/11/25.
//

import EstalviaDesignSystem
import SwiftUI

struct HomeView: View {
	@State var viewModel: HomeViewModel
	var body: some View {
		VStack {
			List(viewModel.expenses) { expense in
				HomeFactory.makeExpenseListView(from: expense).swipeActions {
					Button(role: .destructive) {
						viewModel.deleteExpense(expense)
					} label: {
						Label("Delete", systemImage: "trash.fill")
					}.estalviaTheme(.medium)
				}
			}
			Spacer()
			HStack {
				Spacer(minLength: 0)
				Button("+") {
					viewModel.didPressAddExpense {
						viewModel.getExpenses()
					}
				}.estalviaPrimaryButton(
					size: .circle,
					color: .estalviaPrimaryGreen
				).frame(maxWidth: 44).padding(.trailing, 24)
			}
		}.onAppear(perform: {
			viewModel.getExpenses()
		}).padding(.bottom, 16)
	}

	public init(
		viewModel: HomeViewModel
	) {
		self.viewModel = viewModel
	}
}

// #Preview {
//	HomeView(viewModel: H)
// }
