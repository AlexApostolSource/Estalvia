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
		formatter.locale = Locale(identifier: CurrencySymbolHelper.code())
		formatter.numberStyle = .currency
		formatter.currencyCode = CurrencySymbolHelper.code()
		formatter.currencySymbol = CurrencySymbolHelper.symbol()
		formatter.minimumFractionDigits = 2
		formatter.maximumFractionDigits = 2
		formatter.usesGroupingSeparator = true
			// No toques positive/negativeFormat: el locale ya coloca el símbolo y separadores
		// 2,500.00€
		return formatter
	}()

	public static func format(_ value: Decimal) -> String {
		euroTrailingFormatter.string(from: value as NSDecimalNumber) ?? "\(value)\(CurrencySymbolHelper.symbol())"
	}
}
