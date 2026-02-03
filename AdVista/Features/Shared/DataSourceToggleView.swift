import SwiftUI

struct DataSourceToggleView: View {
    @ObservedObject var repository: DataRepository

    private var isFirestoreEnabled: Binding<Bool> {
        Binding(
            get: { repository.dataSource == .firestore },
            set: { repository.dataSource = $0 ? .firestore : .csv }
        )
    }

    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.s) {
            HStack(alignment: .center, spacing: Spacing.m) {
                VStack(alignment: .leading, spacing: Spacing.xs) {
                    Text("Source de donnees")
                        .font(AppFonts.sectionTitle)
                    Text(repository.dataSource.displayName)
                        .font(AppFonts.caption)
                        .foregroundStyle(AppColors.mutedText)
                }

                Spacer()

                Toggle("Charger depuis Firestore", isOn: isFirestoreEnabled)
                    .labelsHidden()
            }

            switch repository.loadState {
            case .loading:
                HStack(spacing: Spacing.xs) {
                    ProgressView()
                    Text("Chargement des donnees...")
                        .font(AppFonts.caption)
                        .foregroundStyle(AppColors.mutedText)
                }
            case .failed(let message):
                Text("Echec du chargement : \(message)")
                    .font(AppFonts.caption)
                    .foregroundStyle(AppColors.warning)
            default:
                EmptyView()
            }
        }
        .cardStyle()
        .accessibilityElement(children: .combine)
    }
}

#Preview {
    DataSourceToggleView(repository: DataRepository.mock())
}
