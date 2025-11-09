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
			HStack {
				Spacer()
				Button("+") {}.estalviaPrimaryButton(
					size: .circle,
					color: .estalviaPrimaryGreen
				)
			}
		}
	}
}

#Preview {
	HomeView()
}
