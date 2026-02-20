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
    
    static func createCheckout(
        coordinator: CheckoutCoordinatorProtocol,
        info: CheckoutScreenInfo,
        sendOrderUseCase: SendOrderUseCaseProtocol
    ) -> some View {
        let viewModel = CheckoutViewModel(info: info, sendOrderUseCase: sendOrderUseCase)
        return CheckoutView(coordinator: coordinator, viewModel: viewModel)
    }
}
