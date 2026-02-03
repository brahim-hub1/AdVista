import Combine
import Foundation
import SwiftUI

struct MetricByMonth: Identifiable {
    let id = UUID()
    let month: String
    let value: Double
    let date: Date?
}

struct MetricByProduct: Identifiable {
    let id = UUID()
    let product: String
    let value: Double
}

struct CreatorPerformance: Identifiable {
    let creator: String
    let conversions: Int

    var id: String { creator }
}

@MainActor
final class OverviewViewModel: ObservableObject {
    @Published private(set) var creatives: [AdCreative] = []
    @Published var selectedProduct: String? = nil
    @Published var selectedMonth: String? = nil
    @Published var selectedStatus: String? = nil

    init(repository: DataRepository) {
        repository.$creatives
            .receive(on: DispatchQueue.main)
            .assign(to: &$creatives)
    }

    var availableProducts: [String] {
        let values = Set(creatives.map(\.product)).sorted()
        return values
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
        let values = Set(creatives.map(\.status)).sorted()
        return values
    }

    var filteredCreatives: [AdCreative] {
        creatives.filter { creative in
            let matchesProduct = selectedProduct == nil || creative.product == selectedProduct
            let matchesMonth = selectedMonth == nil || creative.month == selectedMonth
            let matchesStatus = selectedStatus == nil || creative.status == selectedStatus
            return matchesProduct && matchesMonth && matchesStatus
        }
    }

    var kpis: [KPI] {
        let totalBudget = filteredCreatives.reduce(0) { $0 + $1.budget }
        let totalConversions = filteredCreatives.reduce(0) { $0 + $1.conversions }
        let totalRevenue = filteredCreatives.reduce(0) { $0 + $1.revenue }
        let avgRoas = average(filteredCreatives.map(\.roas))
        let avgCpa = average(filteredCreatives.map(\.cpa))
        let creativesCount = filteredCreatives.count

        return [
            KPI(title: "Budget total", value: totalBudget.formattedCurrency(), icon: "banknote", tint: AppColors.accent),
            KPI(title: "Conversions totales", value: totalConversions.formattedNumber(), icon: "cart.fill", tint: AppColors.success),
            KPI(title: "ROAS moyen", value: avgRoas.formattedRatio(), icon: "chart.line.uptrend.xyaxis", tint: AppColors.accent),
            KPI(title: "CPA moyen", value: avgCpa.formattedCurrency(), icon: "target", tint: AppColors.warning),
            KPI(title: "Revenu total", value: totalRevenue.formattedCurrency(), icon: "eurosign.circle.fill", tint: AppColors.success),
            KPI(title: "Creations", value: "\(creativesCount)", icon: "rectangle.stack.fill", tint: AppColors.accent)
        ]
    }

    var roasByMonth: [MetricByMonth] {
        let grouped = Dictionary(grouping: filteredCreatives, by: \.month)
        return grouped.map { month, creatives in
            MetricByMonth(
                month: month,
                value: average(creatives.map(\.roas)),
                date: month.toMonthDate()
            )
        }
        .sorted { lhs, rhs in
            switch (lhs.date, rhs.date) {
            case let (lhsDate?, rhsDate?):
                return lhsDate < rhsDate
            case (nil, nil):
                return lhs.month < rhs.month
            case (nil, _):
                return false
            case (_, nil):
                return true
            }
        }
    }

    var budgetByProduct: [MetricByProduct] {
        let grouped = Dictionary(grouping: filteredCreatives, by: \.product)
        return grouped.map { product, creatives in
            MetricByProduct(
                product: product,
                value: creatives.reduce(0) { $0 + $1.budget }
            )
        }
        .sorted { $0.value > $1.value }
    }

    var topCreatives: [AdCreative] {
        filteredCreatives.sorted { $0.roas > $1.roas }.prefix(5).map { $0 }
    }

    var topCreators: [CreatorPerformance] {
        let grouped = Dictionary(grouping: filteredCreatives, by: \.creator)
        return grouped.map { creator, creatives in
            CreatorPerformance(
                creator: creator,
                conversions: creatives.reduce(0) { $0 + $1.conversions }
            )
        }
        .sorted { $0.conversions > $1.conversions }
        .prefix(5)
        .map { $0 }
    }

    private func average(_ values: [Double]) -> Double {
        let valid = values.filter { $0 > 0 }
        guard !valid.isEmpty else { return 0 }
        return valid.reduce(0, +) / Double(valid.count)
    }
}
