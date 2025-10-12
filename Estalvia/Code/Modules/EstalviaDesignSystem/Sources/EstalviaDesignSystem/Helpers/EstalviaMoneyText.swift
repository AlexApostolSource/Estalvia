import Foundation

public protocol CurrencySymbolHelperProtocol {
    static func code() -> String
    static func symbol() -> String
}

public struct CurrencySymbolHelper: CurrencySymbolHelperProtocol {
    private static let formatter = NumberFormatter()
    public static func code() -> String {
            return Locale.autoupdatingCurrent.currency?.identifier
            ?? Locale.autoupdatingCurrent.identifier
    }

    public static func symbol() -> String {
        formatter.numberStyle = .currency
        formatter.currencyCode = code()
        return formatter.currencySymbol ?? code()
    }

	public init () {}
}
