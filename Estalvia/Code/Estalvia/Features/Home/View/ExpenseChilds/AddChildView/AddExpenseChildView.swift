//
//  AddExpenseChildView.swift
//  Estalvia
//
//  Created by Alex.personal on 2/12/25.
//

import EstalviaDesignSystem
import SwiftUI

struct AddExpenseChildView: View {
	@State var viewModel: AddExpenseChildViewModel
	private var onSaved: (() -> Void)?

	public init(viewModel: AddExpenseChildViewModel, onSaved: (() -> Void)? = nil) {
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
					viewModel.addChild()
					onSaved?()
				})
		}
	}
}

#Preview {
//	HomeViewAddExpenseView()
}
