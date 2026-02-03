import Charts
import SwiftUI

struct BudgetByProductChart: View {
    let data: [MetricByProduct]

    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.m) {
            Text("Budget par produit")
                .font(AppFonts.sectionTitle)

            if data.isEmpty {
                Text("Aucune donnee de budget disponible.")
                    .font(AppFonts.caption)
                    .foregroundStyle(AppColors.mutedText)
            } else {
                Chart(data) { item in
                    BarMark(
                        x: .value("Budget", item.value),
                        y: .value("Produit", item.product)
                    )
                    .foregroundStyle(AppColors.success)
                    .cornerRadius(6)
                }
                .chartXAxis {
                    AxisMarks(position: .bottom)
                }
                .frame(height: CGFloat(max(180, data.count * 44)))
            }
        }
        .cardStyle()
    }
}

#Preview {
    BudgetByProductChart(data: [
        MetricByProduct(product: "AG1 Powder", value: 12450),
        MetricByProduct(product: "AG1 Travel", value: 8450)
    ])
    .padding()
}
