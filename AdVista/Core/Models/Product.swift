import Foundation

struct Product: Identifiable, Hashable {
    let name: String

    var id: String { name }
}
