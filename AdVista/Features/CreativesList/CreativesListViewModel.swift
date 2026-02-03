import Combine
import Foundation

enum CreativesSortOption: String, CaseIterable, Identifiable {
    case roas = "ROAS"
    case date = "Date"
    case budget = "Budget"

    var id: String { rawValue }
}

@MainActor
final class CreativesListViewModel: ObservableObject {
    @Published private(set) var creatives: [AdCreative] = []
    @Published var searchText: String = ""
    @Published var selectedProduct: String? = nil
    @Published var selectedMonth: String? = nil
    @Published var selectedStatus: String? = nil
    @Published var sortOption: CreativesSortOption = .roas

    init(repository: DataRepository) {
        repository.$creatives
            .receive(on: DispatchQueue.main)
            .assign(to: &$creatives)
    }

    var availableProducts: [String] {
        Set(creatives.map(\.product)).sorted()
    }

    var availableMonths: [String] {
        let values = Set(creatives.map(\.month))
        return values.sorted { lhs, rhs in
            switch (lhs.toMonthDate(), rhs.toMonthDate()) {
            case let (lhsDate?, rhsDate?):
                return lhsDate < rhsDate
            case (nil, nil):
                return lhs < rhs
            case (nil, _):
                return false
            case (_, nil):
                return true
            }
        }
    }

    var availableStatuses: [String] {
        Set(creatives.map(\.status)).sorted()
    }

    var filteredCreatives: [AdCreative] {
        let filtered = creatives.filter { creative in
            let matchesProduct = selectedProduct == nil || creative.product == selectedProduct
            let matchesMonth = selectedMonth == nil || creative.month == selectedMonth
            let matchesStatus = selectedStatus == nil || creative.status == selectedStatus

            let matchesSearch: Bool
            if searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                matchesSearch = true
            } else {
                let query = searchText.lowercased()
                matchesSearch = creative.adName.lowercased().contains(query)
                    || creative.product.lowercased().contains(query)
                    || creative.creator.lowercased().contains(query)
                    || creative.contentType.lowercased().contains(query)
                    || creative.angle.lowercased().contains(query)
            }

            return matchesProduct && matchesMonth && matchesStatus && matchesSearch
        }

        return filtered.sorted(by: sortComparator)
    }

    private func sortComparator(lhs: AdCreative, rhs: AdCreative) -> Bool {
        switch sortOption {
        case .roas:
            return lhs.roas > rhs.roas
        case .budget:
            return lhs.budget > rhs.budget
        case .date:
            let lhsDate = lhs.launchDate ?? lhs.month.toMonthDate() ?? .distantPast
            let rhsDate = rhs.launchDate ?? rhs.month.toMonthDate() ?? .distantPast
            return lhsDate > rhsDate
        }
    }
}
