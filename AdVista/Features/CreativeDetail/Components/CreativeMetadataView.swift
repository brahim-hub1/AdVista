import SwiftUI

struct CreativeMetadataView: View {
    let items: [(String, String)]

    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.s) {
            Text("Metadonnees")
                .font(AppFonts.sectionTitle)

            ForEach(items, id: \.0) { item in
                HStack {
                    Text(item.0)
                        .font(AppFonts.caption)
                        .foregroundStyle(AppColors.mutedText)
                    Spacer()
                    Text(item.1)
                        .font(AppFonts.body)
                }

                if item.0 != items.last?.0 {
                    Divider()
                }
            }
        }
        .cardStyle()
    }
}

#Preview {
    CreativeMetadataView(items: [
        ("Type de contenu", "Image"),
        ("Angle", "Digestive"),
        ("Accroche", "Challenge")
    ])
    .padding()
}
