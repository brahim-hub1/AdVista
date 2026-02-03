import SwiftUI

struct TabBarView: View {
    let repository: DataRepository

    var body: some View {
        TabView {
            NavigationStack {
                OverviewView(repository: repository)
            }
            .tabItem {
                Label("Vue d'ensemble", systemImage: "chart.line.uptrend.xyaxis")
            }

            NavigationStack {
                CreativesListView(repository: repository)
            }
            .tabItem {
                Label("Creations", systemImage: "rectangle.stack.person.crop")
            }
        }
    }
}

#Preview {
    TabBarView(repository: DataRepository.mock())
}
