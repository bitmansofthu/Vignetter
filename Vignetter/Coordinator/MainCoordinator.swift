//
//  BaseCoordinator.swift
//  Vignetter
//
//  Created by Ferenc Knebl on 2026. 02. 18..
//

import Combine
import Foundation
import SwiftUI

enum MainDestination: CoordinatorDestination {
    case countySelector(_ info: OrderInfo)
    case checkout(_ info: OrderInfo)
    
    @ViewBuilder
    var view: some View {
        switch self {
        case let .countySelector(info):
            ScreenFactory.createCountySelector(info: info)
        case let .checkout(info):
            ScreenFactory.createCheckout(info: info)
        }
    }
}

class MainCoordinator: BaseCoordinator<MainDestination, DashboardView> {

    init() {
        super.init {
            DashboardView(viewModel: DashboardViewModel())
        }
    }
    
    func showCountySelector(orderInfo: OrderInfo) {
        push(destination: .countySelector(orderInfo))
    }
    
    func showCheckout(orderInfo: OrderInfo) {
        push(destination: .checkout(orderInfo))
    }
}
