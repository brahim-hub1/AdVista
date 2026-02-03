import Foundation
import FirebaseFirestore

final class FirestoreLoaderService {
    private let collection: String
    private let db: Firestore

    private static let iso8601WithFractional: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        return formatter
    }()

    init(
        collection: String = "Creat",
        db: Firestore = Firestore.firestore()
    ) {
        self.collection = collection
        self.db = db
    }

    func loadCreatives() async throws -> [AdCreative] {
        let snapshot = try await db.collection(collection).getDocuments()
        return snapshot.documents.compactMap { document in
            let data = document.data()
            return AdCreativeMapper.creative { key in
                Self.stringValue(data[key])
            }
        }
    }

    private static func stringValue(_ value: Any?) -> String {
        switch value {
        case let string as String:
            return string
        case let number as NSNumber:
            return number.stringValue
        case let bool as Bool:
            return bool ? "true" : "false"
        case let date as Date:
            return iso8601WithFractional.string(from: date)
        case let timestamp as Timestamp:
            return iso8601WithFractional.string(from: timestamp.dateValue())
        case nil:
            return ""
        default:
            return String(describing: value ?? "")
        }
    }
}
