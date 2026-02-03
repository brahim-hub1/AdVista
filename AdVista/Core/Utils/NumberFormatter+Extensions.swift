import Foundation

enum KPIFormatters {
    static let currency: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "fr_FR")
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 0
        return formatter
    }()

    static let decimal: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "fr_FR")
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 0
        return formatter
    }()

    static let ratio: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "fr_FR")
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 0
        return formatter
    }()

    static let percent: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "fr_FR")
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 0
        return formatter
    }()
}

extension Double {
    func formattedCurrency() -> String {
        KPIFormatters.currency.string(from: NSNumber(value: self)) ?? "€0"
    }

    func formattedNumber(maxFractionDigits: Int = 0) -> String {
        let formatter = KPIFormatters.decimal
        formatter.maximumFractionDigits = maxFractionDigits
        return formatter.string(from: NSNumber(value: self)) ?? "0"
    }

    func formattedRatio() -> String {
        let value = KPIFormatters.ratio.string(from: NSNumber(value: self)) ?? "0"
        return "\(value)x"
    }

    func formattedPercent() -> String {
        let value = KPIFormatters.percent.string(from: NSNumber(value: self)) ?? "0"
        return "\(value)%"
    }
}

extension Int {
    func formattedNumber() -> String {
        KPIFormatters.decimal.string(from: NSNumber(value: self)) ?? "0"
    }
}
