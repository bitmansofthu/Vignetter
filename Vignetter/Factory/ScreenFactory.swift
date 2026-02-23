//
//  ScreenFactory.swift
//  Vignetter
//
//  Created by Ferenc Knebl on 2026. 02. 19..
//

import SwiftUI

@MainActor
class ScreenFactory {

    static func createDashboard(
        coordinator: DashboardCoordinatorProtocol
    ) -> some View {
        let viewModel = DashboardViewModel()
        return DashboardView(coordinator: coordinator, viewModel: viewModel)
    }
    
    static func createCountySelector(
        coordinator: CountySelectorCoordinatorProtocol,
        info: OrderInfo
    ) -> some View {
        let viewModel = CountySelectorViewModel(info: info)
        return CountySelectorView(coordinator: coordinator, viewModel: viewModel)
    }
    
    static func createCheckout(
        coordinator: CheckoutCoordinatorProtocol,
        info: OrderInfo
    ) -> some View {
        let viewModel = CheckoutViewModel(info: info)
        return CheckoutView(coordinator: coordinator, viewModel: viewModel)
    }
}
