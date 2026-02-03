import SwiftUI

struct SidebarView: View {
    @Binding var selection: RootDestination?

    var body: some View {
        List(selection: $selection) {
            NavigationLink(value: RootDestination.overview) {
                Label("Vue d'ensemble", systemImage: "chart.line.uptrend.xyaxis")
            }
            NavigationLink(value: RootDestination.creatives) {
                Label("Creations", systemImage: "rectangle.stack.person.crop")
            }
        }
        .listStyle(.sidebar)
        .navigationTitle("AdVista")
    }
}

#Preview {
    NavigationSplitView {
        SidebarView(selection: .constant(.overview))
    } detail: {
        Text("Apercu")
    }
}
