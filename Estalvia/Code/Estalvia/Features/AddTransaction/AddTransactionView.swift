//
//  AddTransactionView.swift
//  Estalvia
//
//  Created by Alex.personal on 9/12/25.
//

import EstalviaDesignSystem
import SwiftUI

struct AddTransactionView: View {
	@State var viewModel: AddTransactionViewModel
	var body: some View {
		VStack {
			EstalviaTextField(title: "Cantidad", text: $viewModel.amount)
			EstalviaTextField(title: "Categoria", text: $viewModel.category)
			EstalviaTextField(title: "Descripcion", text: $viewModel.description)
		}.padding(16)
	}
}

#Preview {
	AddTransactionView(viewModel: AddTransactionViewModel())
}
