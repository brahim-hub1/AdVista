import Foundation

enum DataLoadState: Equatable {
    case idle
    case loading
    case loaded
    case failed(String)
}

@MainActor
final class DataRepository: ObservableObject {
    @Published private(set) var creatives: [AdCreative] = []
    @Published private(set) var loadState: DataLoadState = .idle
    @Published var dataSource: DataSourceType = .csv {
        didSet {
            if oldValue != dataSource {
                load()
            }
        }
    }

    private let loader: CreativeDataLoader

    init(loader: CreativeDataLoader = CreativeDataLoader(), preloaded: [AdCreative]? = nil) {
        self.loader = loader
        if let preloaded {
            creatives = preloaded
            loadState = .loaded
        } else {
            load()
        }
    }

    func load() {
        loadState = .loading
        let source = dataSource

        Task {
            do {
                let loaded = try await loader.loadCreatives(source: source)
                await MainActor.run {
                    guard self.dataSource == source else { return }
                    self.creatives = loaded
                    self.loadState = .loaded
                }
            } catch {
                await MainActor.run {
                    guard self.dataSource == source else { return }
                    self.loadState = .failed(error.localizedDescription)
                }
            }
        }
    }
}
