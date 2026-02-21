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
    
    static func createCountySelector(
        coordinator: CountySelectorCoordinatorProtocol,
        info: OrderInfo,
        getHighwayInfoUseCase: GetHighwayInfoUseCaseProtocol
    ) -> some View {
        let viewModel = CountySelectorViewModel(info: info, getHighwayInfoUseCase: getHighwayInfoUseCase)
        return CountySelectorView(coordinator: coordinator, viewModel: viewModel)
    }
    
    static func createCheckout(
        coordinator: CheckoutCoordinatorProtocol,
        info: OrderInfo,
        sendOrderUseCase: SendOrderUseCaseProtocol
    ) -> some View {
        let viewModel = CheckoutViewModel(info: info, sendOrderUseCase: sendOrderUseCase)
        return CheckoutView(coordinator: coordinator, viewModel: viewModel)
    }
}
