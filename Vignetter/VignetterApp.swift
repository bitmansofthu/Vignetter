//
//  VignetterApp.swift
//  Vignetter
//
//  Created by Ferenc Knebl on 2026. 02. 17..
//

import SwiftUI

@main
struct VignetterApp: App {
    // TODO: DI
    @StateObject var coordinator = MainCoordinator(apiClient: APIClient())
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $coordinator.path) {
                coordinator.startView()
                    .toolbarBackground(.lime, for: .navigationBar)
                    .toolbarColorScheme(.light, for: .navigationBar)
                    .toolbarBackground(.visible, for: .navigationBar)
            }
        }
    }
}
