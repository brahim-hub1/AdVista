import SwiftUI

struct TopCreativesList: View {
    let creatives: [AdCreative]

    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.m) {
            Text("Meilleures creations")
                .font(AppFonts.sectionTitle)

            if creatives.isEmpty {
                Text("Aucune creation trouvee pour les filtres selectionnes.")
                    .font(AppFonts.caption)
                    .foregroundStyle(AppColors.mutedText)
            } else {
                ForEach(creatives) { creative in
                    NavigationLink {
                        CreativeDetailView(creative: creative)
                    } label: {
                        CreativeRowView(creative: creative, compact: true)
                    }
                    .buttonStyle(.plain)

                    if creative.id != creatives.last?.id {
                        Divider()
                    }
                }
            }
        }
        .cardStyle()
    }
}

#Preview {
    TopCreativesList(creatives: MockData.sampleCreatives.prefix(3).map { $0 })
        .padding()
}
