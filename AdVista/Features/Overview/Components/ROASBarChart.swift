import Charts
import SwiftUI

struct ROASBarChart: View {
    let data: [MetricByMonth]

    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.m) {
            Text("ROAS par mois")
                .font(AppFonts.sectionTitle)

            if data.isEmpty {
                Text("Aucune donnee de ROAS disponible.")
                    .font(AppFonts.caption)
                    .foregroundStyle(AppColors.mutedText)
            } else {
                Chart(data) { item in
                    AreaMark(
                        x: .value("Mois", item.month),
                        y: .value("ROAS", item.value)
                    )
                    .foregroundStyle(AppColors.accent.opacity(0.18))
                    .interpolationMethod(.catmullRom)

                    LineMark(
                        x: .value("Mois", item.month),
                        y: .value("ROAS", item.value)
                    )
                    .foregroundStyle(AppColors.accent)
                    .lineStyle(StrokeStyle(lineWidth: 3))
                    .interpolationMethod(.catmullRom)

                    PointMark(
                        x: .value("Mois", item.month),
                        y: .value("ROAS", item.value)
                    )
                    .foregroundStyle(AppColors.accent)
                }
                .chartYAxis {
                    AxisMarks(position: .leading)
                }
                .frame(height: 200)
            }
        }
        .cardStyle()
    }
}

#Preview {
    ROASBarChart(data: [
        MetricByMonth(month: "Aug 2025", value: 2.8, date: nil),
        MetricByMonth(month: "Sep 2025", value: 3.2, date: nil),
        MetricByMonth(month: "Oct 2025", value: 4.1, date: nil)
    ])
    .padding()
}
