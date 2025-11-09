//
//  HomeView.swift
//  Estalvia
//
//  Created by Alex.personal on 9/11/25.
//

import EstalviaDesignSystem
import SwiftUI

struct HomeView: View {
	var body: some View {
		VStack {
			Spacer()
			HStack {
				Spacer(minLength: 0)
				Button("+") {}.estalviaPrimaryButton(
					size: .circle,
					color: .estalviaPrimaryGreen
				).frame(maxWidth: 44).padding(.trailing, 24)
			}
		}.padding(.bottom, 16)
	}
}

#Preview {
	HomeView()
}
