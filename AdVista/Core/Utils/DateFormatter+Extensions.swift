import Foundation

enum DateFormatters {
    static let frenchMonthYear: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "fr_FR")
        formatter.dateFormat = "MMMM yyyy"
        return formatter
    }()

    static let frenchShortDate: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "fr_FR")
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter
    }()
}

extension String {
    func toMonthDate() -> Date? {
        DateFormatters.frenchMonthYear.date(from: self)
    }

    func toShortDate() -> Date? {
        DateFormatters.frenchShortDate.date(from: self)
    }
}
