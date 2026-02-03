import Foundation

final class CreativeDataLoader {
    private let csvLoader: CSVLoaderService
    private let firestoreLoader: FirestoreLoaderService

    init(
        csvLoader: CSVLoaderService = CSVLoaderService(),
        firestoreLoader: FirestoreLoaderService = FirestoreLoaderService()
    ) {
        self.csvLoader = csvLoader
        self.firestoreLoader = firestoreLoader
    }

    func loadCreatives(source: DataSourceType) async throws -> [AdCreative] {
        switch source {
        case .csv:
            return try csvLoader.loadCreatives()
        case .firestore:
            return try await firestoreLoader.loadCreatives()
        }
    }
}
