import SwiftUI

struct CreativeKPICard: View {
    let kpi: KPI

    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.s) {
            HStack(spacing: Spacing.s) {
                Image(systemName: kpi.icon)
                    .foregroundStyle(kpi.tint)
                Text(kpi.title)
                    .font(AppFonts.caption)
                    .foregroundStyle(AppColors.mutedText)
            }

            Text(kpi.value)
                .font(AppFonts.cardTitle)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
                .allowsTightening(true)
                .layoutPriority(1)
        }
        .frame(maxWidth: .infinity, minHeight: 96, alignment: .leading)
        .cardStyle()
    }
}

#Preview {
    CreativeKPICard(kpi: KPI(title: "Budget", value: "€4,500", icon: "banknote", tint: AppColors.accent))
        .padding()
}
