import Foundation

enum DataSourceType: String, CaseIterable {
    case csv
    case firestore

    var displayName: String {
        switch self {
        case .csv:
            return "CSV"
        case .firestore:
            return "Firestore"
        }
    }
}
