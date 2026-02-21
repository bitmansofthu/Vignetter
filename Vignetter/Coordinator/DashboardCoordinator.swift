//
//  DashboardCoordinator.swift
//  Vignetter
//
//  Created by Ferenc Knebl on 2026. 02. 21..
//

import SwiftUI

enum DashboardCoordinatorAction {
    case showCheckout(_ info: OrderInfo)
    case showCountySelector(_ info: OrderInfo)
}

protocol DashboardCoordinatorProtocol {
    func dashboardAction(_ action: DashboardCoordinatorAction)
}

extension MainCoordinator: DashboardCoordinatorProtocol {
    func dashboardAction(_ action: DashboardCoordinatorAction) {
        switch action {
        case let .showCheckout(info):
            path.append(Destination.checkout(info))
        case let .showCountySelector(info):
            path.append(Destination.countySelector(info))
        }
    }
}

class PreviewDashboardCoordinator: DashboardCoordinatorProtocol {
    func dashboardAction(_ action: DashboardCoordinatorAction) { }
}
