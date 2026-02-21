//
//  CountySelectorCoordinator.swift
//  Vignetter
//
//  Created by Ferenc Knebl on 2026. 02. 21..
//

import SwiftUI

enum CountySelectorCoordinatorAction {
    case cancelScreen
    case showCheckout(_ info: OrderInfo)
}

protocol CountySelectorCoordinatorProtocol {
    func countySelectorAction(_ action: CountySelectorCoordinatorAction)
}

extension MainCoordinator: CountySelectorCoordinatorProtocol {
    func countySelectorAction(_ action: CountySelectorCoordinatorAction) {
        switch action {
        case let .showCheckout(info):
            path.append(Destination.checkout(info))
        case .cancelScreen:
            goBack()
        }
    }
}

class PreviewCountrySelectorCoordinator: CountySelectorCoordinatorProtocol {
    func countySelectorAction(_ action: CountySelectorCoordinatorAction) { }
}
