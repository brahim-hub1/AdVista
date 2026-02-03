import SwiftUI

struct OverviewView: View {
    @StateObject private var viewModel: OverviewViewModel
    @ObservedObject private var repository: DataRepository
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass

    init(repository: DataRepository) {
        self.repository = repository
        _viewModel = StateObject(wrappedValue: OverviewViewModel(repository: repository))
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: Spacing.l) {
                header
                dataSourceToggle
                filterBar
                kpiGrid
                ROASBarChart(data: viewModel.roasByMonth)
                BudgetByProductChart(data: viewModel.budgetByProduct)
                TopCreativesList(creatives: viewModel.topCreatives)
                topCreatorsCard
            }
            .padding(Spacing.l)
        }
        .background(AppColors.backgroundGradient.ignoresSafeArea())
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: Spacing.xs) {
            Text("Tableau de bord")
                .font(AppFonts.sectionTitle)
                .foregroundStyle(AppColors.mutedText)
            Text("Vue d'ensemble")
                .font(AppFonts.screenTitle)
        }
    }

    private var dataSourceToggle: some View {
        DataSourceToggleView(repository: repository)
    }

    private var filterBar: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: Spacing.s) {
                filterMenu(
                    title: viewModel.selectedProduct ?? "Tous les produits",
                    systemImage: "shippingbox"
                ) {
                    Button("Tous les produits") { viewModel.selectedProduct = nil }
                    ForEach(viewModel.availableProducts, id: \.self) { product in
                        Button(product) { viewModel.selectedProduct = product }
                    }
                }

                filterMenu(
                    title: viewModel.selectedMonth ?? "Tous les mois",
                    systemImage: "calendar"
                ) {
                    Button("Tous les mois") { viewModel.selectedMonth = nil }
                    ForEach(viewModel.availableMonths, id: \.self) { month in
                        Button(month) { viewModel.selectedMonth = month }
                    }
                }

                filterMenu(
                    title: viewModel.selectedStatus ?? "Tous les statuts",
                    systemImage: "bolt.fill"
                ) {
                    Button("Tous les statuts") { viewModel.selectedStatus = nil }
                    ForEach(viewModel.availableStatuses, id: \.self) { status in
                        Button(status) { viewModel.selectedStatus = status }
                    }
                }
            }
            .padding(.vertical, Spacing.xs)
        }
    }

    private func filterMenu(
        title: String,
        systemImage: String,
        @ViewBuilder content: @escaping () -> some View
    ) -> some View {
        Menu(content: content) {
            Label(title, systemImage: systemImage)
                .font(AppFonts.caption)
                .padding(.horizontal, Spacing.m)
                .padding(.vertical, Spacing.s)
                .background(AppColors.cardBackground)
                .clipShape(Capsule())
                .overlay(
                    Capsule().stroke(AppColors.cardBorder, lineWidth: 1)
                )
        }
    }

    private var kpiGrid: some View {
        let columnCount = horizontalSizeClass == .regular ? 3 : 1
        let columns = Array(repeating: GridItem(.flexible(), spacing: Spacing.m), count: columnCount)

        return LazyVGrid(columns: columns, spacing: Spacing.m) {
            ForEach(viewModel.kpis) { kpi in
                KPIStatCard(kpi: kpi)
            }
        }
    }

    private var topCreatorsCard: some View {
        VStack(alignment: .leading, spacing: Spacing.m) {
            Text("Meilleurs createurs")
                .font(AppFonts.sectionTitle)

            if viewModel.topCreators.isEmpty {
                Text("Aucune donnee disponible pour les filtres selectionnes.")
                    .font(AppFonts.caption)
                    .foregroundStyle(AppColors.mutedText)
            } else {
                ForEach(viewModel.topCreators) { creator in
                    HStack {
                        Text(creator.creator)
                            .font(AppFonts.body)
                        Spacer()
                        Text("\(creator.conversions.formattedNumber()) conv.")
                            .font(AppFonts.caption)
                            .foregroundStyle(AppColors.mutedText)
                    }

                    if creator.id != viewModel.topCreators.last?.id {
                        Divider()
                    }
                }
            }
        }
        .cardStyle()
    }
}

#Preview {
    OverviewView(repository: DataRepository.mock())
}
