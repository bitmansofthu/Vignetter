//
//  CheckoutCoordinator.swift
//  Vignetter
//
//  Created by Ferenc Knebl on 2026. 02. 21..
//

import SwiftUI

enum CheckoutCoordinatorAction {
    case cancelScreen
    case gotoDashboard
}

protocol CheckoutCoordinatorProtocol {
    func checkoutAction(_ action: CheckoutCoordinatorAction)
}

extension MainCoordinator: CheckoutCoordinatorProtocol {
    func checkoutAction(_ action: CheckoutCoordinatorAction) {
        switch action {
        case .cancelScreen:
            goBack()
        case .gotoDashboard:
            reset()
        }
    }
}

class PreviewCheckoutCoordinator: CheckoutCoordinatorProtocol {
    func checkoutAction(_ action: CheckoutCoordinatorAction) { }
}
