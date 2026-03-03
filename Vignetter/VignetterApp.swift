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
    @StateObject var appCoordinator: AppCoordinator = AppCoordinator()

    var body: some Scene {
        WindowGroup {
            ZStack {
                switch appCoordinator.appState {
                case .login:
                    LoginView()
                case .dashboard:
                    NavigationStack(path: $mainCoordinator.path) {
                        mainCoordinator.navigationView
                    }
                    .sheet(isPresented: $mainCoordinator.isSheetPresented) {
                        
                    }
                    .environmentObject(mainCoordinator)
                }
            }
            .environmentObject(appCoordinator)
        }
    }
}
