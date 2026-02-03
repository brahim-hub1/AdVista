import SwiftUI

@MainActor
final class CreativeDetailViewModel: ObservableObject {
    let creative: AdCreative

    init(creative: AdCreative) {
        self.creative = creative
    }

    var kpis: [KPI] {
        [
            KPI(title: "Budget", value: creative.budget.formattedCurrency(), icon: "banknote", tint: AppColors.accent),
            KPI(title: "ROAS", value: creative.roas.formattedRatio(), icon: "chart.line.uptrend.xyaxis", tint: AppColors.success),
            KPI(title: "CPA", value: creative.cpa.formattedCurrency(), icon: "target", tint: AppColors.warning),
            KPI(title: "Revenu", value: creative.revenue.formattedCurrency(), icon: "eurosign.circle.fill", tint: AppColors.success),
            KPI(title: "Impressions", value: creative.impressions.formattedNumber(), icon: "eye.fill", tint: AppColors.accent),
            KPI(title: "Clics", value: creative.clicks.formattedNumber(), icon: "cursorarrow.click", tint: AppColors.accent),
            KPI(title: "CTR", value: creative.ctr.formattedPercent(), icon: "scope", tint: AppColors.warning)
        ]
    }

    var metadata: [(String, String)] {
        [
            ("Type de contenu", creative.contentType),
            ("Angle", creative.angle),
            ("Accroche", creative.hook),
            ("Mois", creative.month),
            ("Statut", creative.status)
        ]
    }
}
