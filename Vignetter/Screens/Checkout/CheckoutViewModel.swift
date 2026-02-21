//
//  CheckoutViewModel.swift
//  Vignetter
//
//  Created by Ferenc Knebl on 2026. 02. 19..
//

import Foundation
import Combine

enum CheckoutViewState {
    case info(OrderInfo)
    case success
}

class CheckoutViewModel: ObservableObject {
    
    // MARK: - Published Properties
    
    @Published var state: CheckoutViewState
    @Published var showErrorAlert: Bool = false
    @Published var errorMessage: String?
    
    var summaryPrice: Int {
        if info.vignette.type == .county {
            return info.counties.count * (info.vignette.trxFee + info.vignette.price)
        } else {
            return info.vignette.price + info.vignette.trxFee
        }
    }
    
    // MARK: - Private Properties
    
    let sendOrderUseCase: SendOrderUseCaseProtocol
    let info: OrderInfo
    
    // MARK: - Lifecycle
    
    init(
        info: OrderInfo,
        sendOrderUseCase: SendOrderUseCaseProtocol
    ) {
        self.info = info
        self.sendOrderUseCase = sendOrderUseCase
        self.state = .info(info)
    }
    
    func sendOrder() async {
        do {
            try await sendOrderUseCase.execute(
                vignette: info.vignette,
                counties: info.counties,
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

#if DEBUG
extension CheckoutViewModel {
    static let preview: CheckoutViewModel = {
        CheckoutViewModel(info: .preview, sendOrderUseCase: SendOrderUseCasePreview())
    }()
}
#endif
