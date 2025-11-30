//
//  HomeView.swift
//  Estalvia
//
//  Created by Alex.personal on 9/11/25.
//

import EstalviaDesignSystem
import SwiftUI

struct HomeView<Coordinator: EstalviaNavigationCoordinatorProtocol>: View
where Coordinator.State == HomeCoordinator.State {
	@State var viewModel: HomeViewModel<Coordinator>

	@State private var isSheetPresented = false
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
		isSheetPresented: Bool = false,
		viewModel: HomeViewModel<Coordinator>
	) {
		self.viewModel = viewModel
		self.isSheetPresented = isSheetPresented
	}
}

// #Preview {
//	HomeView(viewModel: H)
// }
