#if DEBUG
import Foundation

enum MockData {
    static let sampleCreatives: [AdCreative] = [
        AdCreative(
            id: UUID(),
            adName: "AG1_Image statique_Digestion_V1",
            product: "AG1 Powder",
            creator: "In-House",
            contentType: "Image statique",
            angle: "Digestion",
            hook: "Challenge",
            month: "Août 2025",
            status: "En ligne",
            budget: 5704.02,
            conversions: 250,
            revenue: 27655.0,
            roas: 4.85,
            cpa: 22.82,
            impressions: 652_630,
            clicks: 3_259,
            ctr: 0.5,
            launchDate: "21/08/2025".toShortDate()
        ),
        AdCreative(
            id: UUID(),
            adName: "AG1_Motion-Vidéo_Routine-matinale_V5",
            product: "AG1 Powder",
            creator: "Studio",
            contentType: "Motion/Vidéo",
            angle: "Routine matinale",
            hook: "Avant/Après",
            month: "Août 2025",
            status: "Archivée",
            budget: 12_127.22,
            conversions: 574,
            revenue: 52_802.26,
            roas: 4.35,
            cpa: 21.13,
            impressions: 126_134,
            clicks: 515,
            ctr: 0.41,
            launchDate: "26/08/2025".toShortDate()
        ),
        AdCreative(
            id: UUID(),
            adName: "AG1_Image statique_Promo_V4",
            product: "AG1 Powder",
            creator: "Partner",
            contentType: "Image statique",
            angle: "Promo",
            hook: "Comparatif",
            month: "Août 2025",
            status: "En ligne",
            budget: 9_560.19,
            conversions: 590,
            revenue: 53_902.4,
            roas: 5.64,
            cpa: 16.2,
            impressions: 727_508,
            clicks: 1_456,
            ctr: 0.2,
            launchDate: "05/08/2025".toShortDate()
        )
    ]
}

extension DataRepository {
    static func mock() -> DataRepository {
        DataRepository(preloaded: MockData.sampleCreatives)
    }
}
#endif
