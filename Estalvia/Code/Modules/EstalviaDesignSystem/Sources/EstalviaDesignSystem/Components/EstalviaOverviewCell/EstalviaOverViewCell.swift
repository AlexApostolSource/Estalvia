//
//  EstalviaOverViewCell.swift
//  EstalviaDesignSystem
//
//  Created by Alex.personal on 27/9/25.
//


import SwiftUI

public struct EstalviaOverViewCell: View {
    public var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Resumen Financiero").estalviaTextView(.title)
                Spacer()
                Image(systemName: "pencil")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
            }
            VStack(alignment: .leading) {
                Text("Capital inicial").estalviaTextView(.subtitle)
                Text("€2500.00")
            }.padding(EdgeInsets(top: 24, leading: 0, bottom: 0, trailing: 0))
            VStack(alignment: .leading) {
                Text("Saldo Actual").estalviaTextView(.subtitle)
                Text("€2500.00")
            }.padding(EdgeInsets(top: 24, leading: 0, bottom: 0, trailing: 0))
            Spacer()
        }.padding(EdgeInsets(top: 32, leading: 24, bottom: 32, trailing: 24))

    }
}

public struct EstalviaOverViewCellPreview: View {
    public var body: some View {
        EstalviaOverViewCell()
    }

    public init() {

    }
}

#Preview {
    EstalviaOverViewCellPreview()
}
