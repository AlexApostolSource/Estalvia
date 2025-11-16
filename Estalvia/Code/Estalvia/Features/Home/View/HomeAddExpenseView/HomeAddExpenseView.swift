//
//  HomeAddExpenseView.swift
//  Estalvia
//
//  Created by Alex.personal on 15/11/25.
//

import EstalviaDesignSystem
import SwiftUI

struct HomeViewAddExpenseView: View {
	@ObservedObject var viewModel: HomeAddExpenseViewModel

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
				placeHolderDescription: "", rightButtonAction:  {
					viewModel.saveExpense()
				})
		}
	}
}

#Preview {
//	HomeViewAddExpenseView()
}
