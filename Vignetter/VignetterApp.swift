//
//  VignetterApp.swift
//  Vignetter
//
//  Created by Ferenc Knebl on 2026. 02. 17..
//

import SwiftUI

@main
struct VignetterApp: App {
    @StateObject var coordinator: MainCoordinator
    
    init() {
        self._coordinator = StateObject(wrappedValue: MainCoordinator())
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $coordinator.path) {
                coordinator.startView()
            }
            .environmentObject(coordinator)
        }
    }
}
