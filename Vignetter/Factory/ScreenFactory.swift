//
//  ScreenFactory.swift
//  Vignetter
//
//  Created by Ferenc Knebl on 2026. 02. 19..
//

import SwiftUI

@MainActor
struct ScreenFactory {

    static func createDashboard() -> DashboardView {
        let viewModel = DashboardViewModel()
        return DashboardView(viewModel: viewModel)
    }
    
    static func createCountySelector(info: OrderInfo) -> CountySelectorView {
        let viewModel = CountySelectorViewModel(info: info)
        return CountySelectorView(viewModel: viewModel)
    }
    
    static func createCheckout(info: OrderInfo) -> CheckoutView {
        let viewModel = CheckoutViewModel(info: info)
        return CheckoutView(viewModel: viewModel)
    }
}
