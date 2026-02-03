import SwiftUI

enum RootDestination: Hashable {
    case overview
    case creatives
}

struct RootNavigationView: View {
    @EnvironmentObject private var environment: AppEnvironment
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @State private var selection: RootDestination? = .overview

    var body: some View {
        Group {
            if horizontalSizeClass == .regular {
                NavigationSplitView {
                    SidebarView(selection: $selection)
                } detail: {
                    NavigationStack {
                        detailView
                    }
                }
            } else {
                TabBarView(repository: environment.repository)
            }
        }
        .tint(AppColors.accent)
    }

    @ViewBuilder
    private var detailView: some View {
        switch selection ?? .overview {
        case .overview:
            OverviewView(repository: environment.repository)
        case .creatives:
            CreativesListView(repository: environment.repository)
        }
    }
}

#Preview {
    RootNavigationView()
        .environmentObject(AppEnvironment(repository: DataRepository.mock()))
}
