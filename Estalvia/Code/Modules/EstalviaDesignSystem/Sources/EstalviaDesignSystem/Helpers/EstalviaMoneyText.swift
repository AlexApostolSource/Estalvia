import Foundation

protocol CurrencySymbolHelperProtocol {
    func code() -> String
    func symbol() -> String
}

struct CurrencySymbolHelper: CurrencySymbolHelperProtocol {
    private let formatter = NumberFormatter()
    func code() -> String {
            return Locale.autoupdatingCurrent.currency?.identifier
            ?? Locale.autoupdatingCurrent.currencyCode
            ?? ""
    }


    func symbol() -> String {
        formatter.numberStyle = .currency
        formatter.currencyCode = code()
        return formatter.currencySymbol ?? code()
    }
}

