import Foundation

struct Creator: Identifiable, Hashable {
    let name: String

    var id: String { name }
}
