//
//  NumberFormatter.swift
//  EstalviaDesignSystem
//
//  Created by Alex.personal on 12/10/25.
//

import Foundation

public struct EstalviaNumberFormatter {
	private static let euroTrailingFormatter: NumberFormatter = {
		let formatter = NumberFormatter()
		formatter.locale = Locale(identifier: CurrencySymbolHelper.code()) // punto decimal garantizado
		formatter.numberStyle = .currency
		formatter.currencyCode = CurrencySymbolHelper.code()
		formatter.currencySymbol = CurrencySymbolHelper.symbol()
		formatter.usesGroupingSeparator = true             // sin miles: 2500.00
		formatter.minimumFractionDigits = 2
		formatter.maximumFractionDigits = 2
		formatter.positiveFormat = "0.00¤"                  // número + símbolo al final
		formatter.negativeFormat = "-0.00¤"                 // negativo
		return formatter
	}()

	public static func euroTrailingString(_ value: Decimal) -> String {
		euroTrailingFormatter.string(from: value as NSDecimalNumber) ?? "\(value)\(CurrencySymbolHelper.symbol())"
	}
}
