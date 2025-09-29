//
//  EstalviaButtonPreview.swift
//  Showcase
//
//  Created by Alex.personal on 31/8/25.
//

import SwiftUI
import EstalviaDesignSystem

struct ComponentsList: View {
    var body: some View {
        NavigationStack {
            List {
                NavigationLink(destination: EstalviaButtonView()) {
                    Text("Estalvia Button")
                }
                NavigationLink(destination: EstalviaTextPreview()) {
                    Text("Estalvia Text")
                }
                NavigationLink(destination: EstalviaTextFieldPreview()) {
                    Text("Estalvia TextField")
                }
                NavigationLink(destination: EstalviaOverViewCellPreview()) {
                    Text("Estalvia OverViewCell")
                }
                NavigationLink(destination: EstalviaAmountModalPreview()) {
                    Text("Estalvia AmountModal")
                }
                }.navigationTitle("ComponentsList")
                    .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ComponentsList()
}
