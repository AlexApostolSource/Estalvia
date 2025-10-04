import Foundation

public protocol CurrencySymbolHelperProtocol {
    func code() -> String
    func symbol() -> String
}

public struct CurrencySymbolHelper: CurrencySymbolHelperProtocol {
    private let formatter = NumberFormatter()
    public func code() -> String {
            return Locale.autoupdatingCurrent.currency?.identifier
            ?? Locale.autoupdatingCurrent.currencyCode
            ?? ""
    }


    public func symbol() -> String {
        formatter.numberStyle = .currency
        formatter.currencyCode = code()
        return formatter.currencySymbol ?? code()
    }

	public init () {}
}

