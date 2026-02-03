import Foundation

struct AdCreative: Identifiable, Hashable {
    let id: UUID
    let adName: String
    let product: String
    let creator: String
    let contentType: String
    let angle: String
    let hook: String
    let month: String
    let status: String

    let budget: Double
    let conversions: Int
    let revenue: Double
    let roas: Double
    let cpa: Double
    let impressions: Int
    let clicks: Int
    let ctr: Double

    let launchDate: Date?
}
