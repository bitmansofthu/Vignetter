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
        // TODO: DI
        let apiClient = APIClient()
        let highwayInfoRepository = HighwayInfoRepository(apiClient: apiClient)
        let coordinator = MainCoordinator(
            getHighwayInfoUseCase: GetHighwayInfoUseCase(
                highwayInfoRepository: highwayInfoRepository
            ),
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
