import SwiftUI

struct CreativeRowView: View {
    let creative: AdCreative
    var compact: Bool = false

    var body: some View {
        HStack(alignment: .top, spacing: Spacing.m) {
            VStack(alignment: .leading, spacing: Spacing.xs) {
                Text(creative.adName)
                    .font(AppFonts.cardTitle)
                    .lineLimit(compact ? 1 : 2)

                Text("\(creative.product) • \(creative.creator)")
                    .font(AppFonts.caption)
                    .foregroundStyle(AppColors.mutedText)

                if !compact {
                    StatusBadge(status: creative.status)
                }
            }

            Spacer()

            VStack(alignment: .trailing, spacing: Spacing.xs) {
                Text(creative.budget.formattedCurrency())
                    .font(AppFonts.body)
                Text("ROAS \(creative.roas.formattedRatio())")
                    .font(AppFonts.caption)
                    .foregroundStyle(AppColors.mutedText)
            }
        }
        .padding(.vertical, Spacing.xs)
    }
}

private struct StatusBadge: View {
    let status: String

    var body: some View {
        Text(status)
            .font(AppFonts.caption)
            .padding(.horizontal, Spacing.s)
            .padding(.vertical, Spacing.xs)
            .background(statusColor.opacity(0.18))
            .foregroundStyle(statusColor)
            .clipShape(Capsule())
    }

    private var statusColor: Color {
        let lowercased = status.lowercased()
        if lowercased.contains("ligne") {
            return AppColors.success
        } else if lowercased.contains("pause") {
            return AppColors.warning
        } else if lowercased.contains("arrêt") || lowercased.contains("arret") {
            return AppColors.danger
        } else if lowercased.contains("archiv") {
            return AppColors.mutedText
        } else {
            return AppColors.accent
        }
    }
}

#Preview {
    CreativeRowView(creative: MockData.sampleCreatives[0])
        .padding()
}
