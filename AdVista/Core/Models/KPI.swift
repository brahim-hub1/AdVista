import SwiftUI

struct KPI: Identifiable {
    let id = UUID()
    let title: String
    let value: String
    let icon: String
    let tint: Color
}
