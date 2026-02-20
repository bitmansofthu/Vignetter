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
    @StateObject var coordinator: MainCoordinator
    
    init() {
        let apiClient = APIClient()
        let coordinator = MainCoordinator(
            getHighwayInfoUseCase: GetHighwayInfoUseCase(apiClient: apiClient),
            getVehicleUseCase: GetVehicleUseCase(apiClient: apiClient),
            sendOrderUseCase: SendOrderUseCase(apiClient: apiClient)
        )
        self._coordinator = StateObject(wrappedValue: coordinator)
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $coordinator.path) {
                coordinator.startView()
            }
        }
    }
}
