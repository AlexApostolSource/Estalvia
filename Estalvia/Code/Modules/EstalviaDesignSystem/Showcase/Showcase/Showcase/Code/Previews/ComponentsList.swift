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
                }.navigationTitle("ComponentsList")
                    .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}

#Preview {
    ComponentsList()
}
