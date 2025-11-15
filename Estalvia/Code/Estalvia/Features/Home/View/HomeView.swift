//
//  HomeView.swift
//  Estalvia
//
//  Created by Alex.personal on 9/11/25.
//

import EstalviaDesignSystem
import SwiftUI

struct HomeView: View {
	@State private var isSheetPresented = false
	var body: some View {
		VStack {
			Spacer()
			HStack {
				Spacer(minLength: 0)
				Button("+") {
					isSheetPresented.toggle()
				}.estalviaPrimaryButton(
					size: .circle,
					color: .estalviaPrimaryGreen
				).frame(maxWidth: 44).padding(.trailing, 24)
					.sheet(isPresented: $isSheetPresented) {
					} content: {
						HomeViewAddExpenseView()
						.presentationDetents([.medium])
					}

			}
		}.padding(.bottom, 16)
	}

	public init(
		isSheetPresented: Bool = false,
	) {
		self.isSheetPresented = isSheetPresented
	}
}

#Preview {
	HomeView()
}
