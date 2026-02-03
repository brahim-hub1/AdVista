import Foundation

@MainActor
final class AppEnvironment: ObservableObject {
    @Published var repository: DataRepository

    init(repository: DataRepository? = nil) {
        self.repository = repository ?? DataRepository()
    }
}
