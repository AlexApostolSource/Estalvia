//
//  HomeAddExpenseView.swift
//  Estalvia
//
//  Created by Alex.personal on 15/11/25.
//

import EstalviaDesignSystem
import SwiftUI

struct HomeViewAddExpenseView: View {
	@State var viewModel: HomeAddExpenseViewModel
	@Environment(\.dismiss) private var dismiss
	private var onSaved: (() -> Void)?

	public init(viewModel: HomeAddExpenseViewModel, onSaved: (() -> Void)? = nil) {
		self.viewModel = viewModel
		self.onSaved = onSaved
	}

	var body: some View {
		VStack {
			EstalviaAmountModal(
				titleLabel: "Add Expense",
				amountTitle: "Capital",
				leftButtonTitle: "Cancelar",
				rightButtonTitle: "Acceptar",
				amountText: $viewModel.amount,
				descriptionBinding: $viewModel.description,
				description: "Descripción",
				placeholderAmount: "Capital inicial",
				placeHolderDescription: "", rightButtonAction: {
					let hasOperationFailed = viewModel.saveExpense()
					if !hasOperationFailed { // True means the operation has failed
						onSaved?()
						dismiss()
					}
				})
		}.alert(viewModel.errorTitle, isPresented: $viewModel.isErrorPresented) {
			Button("Aceptar", role: .cancel) {
					  viewModel.isErrorPresented.toggle()
				  }
			  }

	}
}

#Preview {
//	HomeViewAddExpenseView()
}
