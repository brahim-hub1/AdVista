import SwiftUI

struct CreativeDetailView: View {
    @StateObject private var viewModel: CreativeDetailViewModel
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass

    init(creative: AdCreative) {
        _viewModel = StateObject(wrappedValue: CreativeDetailViewModel(creative: creative))
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: Spacing.l) {
                header
                kpiGrid
                CreativeMetadataView(items: viewModel.metadata)
                previewCard
            }
            .padding(Spacing.l)
        }
        .background(AppColors.backgroundGradient.ignoresSafeArea())
        .navigationTitle("Creation")
        .navigationBarTitleDisplayMode(.inline)
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: Spacing.s) {
            Text(viewModel.creative.adName)
                .font(AppFonts.sectionTitle)

            Text("\(viewModel.creative.product) • \(viewModel.creative.creator)")
                .font(AppFonts.caption)
                .foregroundStyle(AppColors.mutedText)

            statusPill(text: viewModel.creative.status)
        }
        .cardStyle()
    }

    private var kpiGrid: some View {
        let columns = Array(
            repeating: GridItem(.flexible(), spacing: Spacing.m),
            count: horizontalSizeClass == .regular ? 3 : 2
        )

        return LazyVGrid(columns: columns, spacing: Spacing.m) {
            ForEach(viewModel.kpis) { kpi in
                CreativeKPICard(kpi: kpi)
            }
        }
    }

    private var previewCard: some View {
        VStack(alignment: .leading, spacing: Spacing.s) {
            Text("Apercu")
                .font(AppFonts.sectionTitle)

            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(AppColors.cardBackground)
                .frame(height: 180)
                .overlay(
                    VStack(spacing: Spacing.s) {
                        Image(systemName: "photo.on.rectangle")
                            .font(.title2)
                            .foregroundStyle(AppColors.mutedText)
                        Text("Apercu indisponible")
                            .font(AppFonts.caption)
                            .foregroundStyle(AppColors.mutedText)
                    }
                )
        }
        .cardStyle()
    }

    private func statusPill(text: String) -> some View {
        Text(text)
            .font(AppFonts.caption)
            .padding(.horizontal, Spacing.s)
            .padding(.vertical, Spacing.xs)
            .background(statusColor(text).opacity(0.18))
            .foregroundStyle(statusColor(text))
            .clipShape(Capsule())
    }

    private func statusColor(_ status: String) -> Color {
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
    NavigationStack {
        CreativeDetailView(creative: MockData.sampleCreatives[0])
    }
}
