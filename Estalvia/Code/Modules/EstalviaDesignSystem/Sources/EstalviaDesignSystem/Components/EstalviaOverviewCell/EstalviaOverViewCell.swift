//
//  EstalviaOverViewCell.swift
//  EstalviaDesignSystem
//
//  Created by Alex.personal on 27/9/25.
//

import SwiftUI

public struct EstalviaOverViewCell: View {
    public let titleLabel: String
    public let subtitleLabel: String
    public let initialAmount: String
    public let remainingAmount: String
    private let currencyHelper: CurrencySymbolHelperProtocol = CurrencySymbolHelper()

    public var body: some View {
        VStack(alignment: .leading) {
            HStack {
                VStack(alignment: .leading) {
                    Text(titleLabel).estalviaTextView(.subtitle)
                    Text("\(initialAmount)\(currencyHelper.symbol())")
                        .estalviaTextView(.amountPrimary).bold()
                }
                Spacer()
                Image(systemName: "pencil")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
            }
            HStack {
                VStack(alignment: .leading) {
                    Text(subtitleLabel).estalviaTextView(.subtitle)
                    Text("\(remainingAmount)\(currencyHelper.symbol())")
                        .estalviaTextView(.amountPrimary).bold()
                }
                Spacer()
                Image(systemName: "pencil")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
            }
            Spacer()
        }.padding(EdgeInsets(top: 32, leading: 24, bottom: 32, trailing: 24))

    }
}

public struct EstalviaOverViewCellPreview: View {
    public var body: some View {
        EstalviaOverViewCell(
            titleLabel: "Capital inicial",
            subtitleLabel: "Saldo Actual",
            initialAmount: "2500",
            remainingAmount: "2500"
        )
    }

    public init() {

    }
}

#Preview {
    EstalviaOverViewCellPreview()
}
