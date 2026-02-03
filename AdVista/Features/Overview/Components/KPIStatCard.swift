import SwiftUI

struct KPIStatCard: View {
    let kpi: KPI

    var body: some View {
        HStack(alignment: .top, spacing: Spacing.m) {
            ZStack {
                Circle()
                    .fill(kpi.tint.opacity(0.18))
                    .frame(width: 40, height: 40)
                Image(systemName: kpi.icon)
                    .foregroundStyle(kpi.tint)
            }

            VStack(alignment: .leading, spacing: Spacing.xs) {
                Text(kpi.title)
                    .font(AppFonts.caption)
                    .foregroundStyle(AppColors.mutedText)
                Text(kpi.value)
                    .font(AppFonts.kpiValue)
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
                    .allowsTightening(true)
                    .layoutPriority(1)
            }

            Spacer()
        }
        .cardStyle()
    }
}

#Preview {
    KPIStatCard(kpi: KPI(title: "Budget total", value: "€12,450", icon: "banknote", tint: AppColors.accent))
        .padding()
}
