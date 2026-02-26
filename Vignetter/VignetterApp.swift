//
//  VignetterApp.swift
//  Vignetter
//
//  Created by Ferenc Knebl on 2026. 02. 17..
//

import FactoryKit
import SwiftUI

@main
struct VignetterApp: App {
    @StateObject var mainCoordinator: MainCoordinator = MainCoordinator()

    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $mainCoordinator.path) {
                mainCoordinator.startView()
            }
            .environmentObject(mainCoordinator)
        }
    }
}
