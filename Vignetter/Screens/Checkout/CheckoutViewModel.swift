//
//  CheckoutViewModel.swift
//  Vignetter
//
//  Created by Ferenc Knebl on 2026. 02. 19..
//

import Foundation
import Combine

struct CheckoutScreenInfo: Hashable {
    let vehicleInformation: VehicleInformation
    let vignette: Vignette
    
    var summaryPrice: Int {
        // TODO: update for selected countries
        vignette.price
    }
}

enum CheckoutViewState {
    case info(CheckoutScreenInfo)
    case success
}

class CheckoutViewModel: ObservableObject {
    
    // MARK: - Published Properties
    
    @Published var state: CheckoutViewState
    @Published var showErrorAlert: Bool = false
    @Published var errorMessage: String?
    
    // MARK: - Private Properties
    
    let sendOrderUseCase: SendOrderUseCaseProtocol
    let info: CheckoutScreenInfo
    
    // MARK: - Lifecycle
    
    init(
        info: CheckoutScreenInfo,
        sendOrderUseCase: SendOrderUseCaseProtocol
    ) {
        self.info = info
        self.sendOrderUseCase = sendOrderUseCase
        self.state = .info(info)
    }
    
    func sendOrder() async {
        do {
            try await sendOrderUseCase.execute(
                vignettes: [info.vignette],
                vehicleInformation: info.vehicleInformation
            )

            state = .success
        } catch SendOrderError.backendError(let message) {
            errorMessage = message
            showErrorAlert = true
        } catch {
            errorMessage = String(localized: "checkout_general_error")
            showErrorAlert = true
        }
    }
    
}
