//
//  HomeAddExpenseView.swift
//  Estalvia
//
//  Created by Alex.personal on 15/11/25.
//

import EstalviaDesignSystem
import SwiftUI

struct HomeViewAddExpenseView: View {
	@State private var amount: String = ""
	@State private var description: String = ""
	var body: some View {
		VStack {
			EstalviaAmountModal(
				titleLabel: "Add Expense",
				amountTitle: "Capital",
				leftButtonTitle: "Cancelar",
				rightButtonTitle: "Acceptar",
				amountText: $amount,
				descriptionBinding: $description,
				description: "Descripción",
				placeholderAmount: "Capital inicial",
				placeHolderDescription: ""
			)
		}
	}
}

#Preview {
	HomeViewAddExpenseView()
}
