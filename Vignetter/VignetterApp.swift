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
    @InjectedObject(\.mainCoordinator) var mainCoordinator

    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $mainCoordinator.path) {
                mainCoordinator.startView()
            }
        }
    }
}
