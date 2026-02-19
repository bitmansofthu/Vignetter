//
//  ScreenFactory.swift
//  Vignetter
//
//  Created by Ferenc Knebl on 2026. 02. 19..
//

import SwiftUI

class ScreenFactory {

    static func createDashboard(
        coordinator: DashboardCoordinatorProtocol,
        getHighwayInfoUseCase: GetHighwayInfoUseCaseProtocol,
        getVehicleUseCase: GetVehicleUseCaseProtocol
    ) -> some View {
        let viewModel = DashboardViewModel(
            getHighwayInfoUseCase: getHighwayInfoUseCase,
            getVehicleUseCase: getVehicleUseCase
        )
        return DashboardView(coordinator: coordinator, viewModel: viewModel)
    }
    
    static func createCountySelector(coordinator: DashboardCoordinatorProtocol) -> some View {
        EmptyView()
    }
    
    static func createCheckout(coordinator: DashboardCoordinatorProtocol) -> some View {
        EmptyView()
    }
    
    static func createSuccess(coordinator: DashboardCoordinatorProtocol) -> some View {
        EmptyView()
    }
}
