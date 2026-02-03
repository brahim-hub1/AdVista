import Foundation

enum AdCreativeMapper {
    private static let iso8601WithFractional: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        return formatter
    }()

    private static let iso8601: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime]
        return formatter
    }()

    static func creative(from value: (String) -> String) -> AdCreative? {
        let adName = cleanText(value(AdCreativeFieldKeys.adName), fallback: "")
        if adName.isEmpty { return nil }

        let product = cleanText(value(AdCreativeFieldKeys.product))
        let creator = cleanText(value(AdCreativeFieldKeys.creator))
        let contentType = cleanText(value(AdCreativeFieldKeys.contentType))
        let angle = cleanText(value(AdCreativeFieldKeys.angle))
        let hook = cleanText(value(AdCreativeFieldKeys.hook))
        let month = cleanText(value(AdCreativeFieldKeys.month))
        let status = cleanText(value(AdCreativeFieldKeys.status))
        let launchDate = parseDate(value(AdCreativeFieldKeys.launchDate))

        let budget = parseDouble(value(AdCreativeFieldKeys.budget)) ?? 0
        let conversions = parseInt(value(AdCreativeFieldKeys.conversions)) ?? 0
        let revenue = parseDouble(value(AdCreativeFieldKeys.revenue)) ?? 0
        let roas = parseDouble(value(AdCreativeFieldKeys.roas)) ?? (budget > 0 ? revenue / budget : 0)
        let cpa = parseDouble(value(AdCreativeFieldKeys.cpa)) ?? (conversions > 0 ? budget / Double(conversions) : 0)
        let impressions = parseInt(value(AdCreativeFieldKeys.impressions)) ?? 0
        let clicks = parseInt(value(AdCreativeFieldKeys.clicks)) ?? 0
        let ctr = parseDouble(value(AdCreativeFieldKeys.ctr)) ?? (impressions > 0 ? Double(clicks) / Double(impressions) * 100 : 0)

        return AdCreative(
            id: UUID(),
            adName: adName,
            product: product,
            creator: creator,
            contentType: contentType,
            angle: angle,
            hook: hook,
            month: month,
            status: status,
            budget: budget,
            conversions: conversions,
            revenue: revenue,
            roas: roas,
            cpa: cpa,
            impressions: impressions,
            clicks: clicks,
            ctr: ctr,
            launchDate: launchDate
        )
    }

    private static func cleanText(_ value: String, fallback: String = "Inconnu") -> String {
        let trimmed = value.trimmingCharacters(in: .whitespacesAndNewlines)
        if trimmed.isEmpty || trimmed == "—" { return fallback }
        return trimmed
    }

    private static func parseDate(_ raw: String) -> Date? {
        let trimmed = raw.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty, trimmed != "—" else { return nil }

        if let short = trimmed.toShortDate() {
            return short
        }

        return iso8601WithFractional.date(from: trimmed) ?? iso8601.date(from: trimmed)
    }

    private static func parseDouble(_ raw: String) -> Double? {
        let trimmed = raw.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty, trimmed != "—" else { return nil }

        var cleaned = trimmed
        cleaned = cleaned.replacingOccurrences(of: "€", with: "")
        cleaned = cleaned.replacingOccurrences(of: "%", with: "")
        cleaned = cleaned.replacingOccurrences(of: "\u{00A0}", with: "")
        cleaned = cleaned.replacingOccurrences(of: " ", with: "")

        if cleaned.contains(",") && !cleaned.contains(".") {
            cleaned = cleaned.replacingOccurrences(of: ",", with: ".")
        }

        return Double(cleaned)
    }

    private static func parseInt(_ raw: String) -> Int? {
        if let value = parseDouble(raw) {
            return Int(value.rounded())
        }
        return nil
    }
}
