//
//  ScreenFactory.swift
//  Vignetter
//
//  Created by Ferenc Knebl on 2026. 02. 19..
//

import SwiftUI

@MainActor
class ScreenFactory {

    static func createDashboard() -> some View {
        let viewModel = DashboardViewModel()
        return DashboardView(viewModel: viewModel)
    }
    
    static func createCountySelector(info: OrderInfo) -> some View {
        let viewModel = CountySelectorViewModel(info: info)
        return CountySelectorView(viewModel: viewModel)
    }
    
    static func createCheckout(info: OrderInfo) -> some View {
        let viewModel = CheckoutViewModel(info: info)
        return CheckoutView(viewModel: viewModel)
    }
}
