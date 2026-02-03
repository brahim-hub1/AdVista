import SwiftUI

struct CreativesListView: View {
    @StateObject private var viewModel: CreativesListViewModel

    init(repository: DataRepository) {
        _viewModel = StateObject(wrappedValue: CreativesListViewModel(repository: repository))
    }

    var body: some View {
        List {
            if viewModel.filteredCreatives.isEmpty {
                ContentUnavailableView("Aucune creation trouvee", systemImage: "rectangle.stack")
                    .listRowBackground(Color.clear)
            } else {
                ForEach(viewModel.filteredCreatives) { creative in
                    NavigationLink {
                        CreativeDetailView(creative: creative)
                    } label: {
                        CreativeRowView(creative: creative)
                    }
                    .listRowBackground(AppColors.cardBackground)
                    .listRowSeparator(.hidden)
                }
            }
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
        .background(AppColors.backgroundGradient)
        .searchable(text: $viewModel.searchText, prompt: "Rechercher des creations")
        .navigationTitle("Creations")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                filtersMenu
            }
        }
    }

    private var filtersMenu: some View {
        Menu {
            Section("Trier par") {
                ForEach(CreativesSortOption.allCases) { option in
                    filterButton(title: option.rawValue, isSelected: viewModel.sortOption == option) {
                        viewModel.sortOption = option
                    }
                }
            }

            Divider()

            Section("Produit") {
                filterButton(title: "Tous les produits", isSelected: viewModel.selectedProduct == nil) {
                    viewModel.selectedProduct = nil
                }
                ForEach(viewModel.availableProducts, id: \.self) { product in
                    filterButton(title: product, isSelected: viewModel.selectedProduct == product) {
                        viewModel.selectedProduct = product
                    }
                }
            }

            Section("Mois") {
                filterButton(title: "Tous les mois", isSelected: viewModel.selectedMonth == nil) {
                    viewModel.selectedMonth = nil
                }
                ForEach(viewModel.availableMonths, id: \.self) { month in
                    filterButton(title: month, isSelected: viewModel.selectedMonth == month) {
                        viewModel.selectedMonth = month
                    }
                }
            }

            Section("Statut") {
                filterButton(title: "Tous les statuts", isSelected: viewModel.selectedStatus == nil) {
                    viewModel.selectedStatus = nil
                }
                ForEach(viewModel.availableStatuses, id: \.self) { status in
                    filterButton(title: status, isSelected: viewModel.selectedStatus == status) {
                        viewModel.selectedStatus = status
                    }
                }
            }
        } label: {
            Label("Filtres", systemImage: "line.3.horizontal.decrease.circle")
        }
    }

    private func filterButton(title: String, isSelected: Bool, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            if isSelected {
                Label(title, systemImage: "checkmark")
            } else {
                Text(title)
            }
        }
    }
}

#Preview {
    NavigationStack {
        CreativesListView(repository: DataRepository.mock())
    }
}
