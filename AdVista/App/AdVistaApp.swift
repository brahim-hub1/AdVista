//
//  AdVistaApp.swift
//  AdVista
//
//  Created by Brahim Demo on 2026-02-03.
//

import SwiftUI
import FirebaseCore

@main
struct AdVistaApp: App {
    @StateObject private var environment = AppEnvironment()

    init() {
        if FirebaseApp.app() == nil {
            FirebaseApp.configure()
        }
    }

    var body: some Scene {
        WindowGroup {
            RootNavigationView()
                .environmentObject(environment)
        }
    }
}
