//
//  SendOrderUseCase.swift
//  Vignetter
//
//  Created by Ferenc Knebl on 2026. 02. 20..
//

import Foundation

protocol SendOrderUseCaseProtocol {
    func execute(vignettes: [Vignette], vehicleInformation: VehicleInformation) async throws
}

enum SendOrderError: Error, LocalizedError {
    case backendError(_ message: String)
}

struct SendOrderUseCase: SendOrderUseCaseProtocol {
    
    private enum Constants {
        static let error = "ERROR"
        static let ok = "OK"
    }
    
    let apiClient: APIClientProtocol
    
    init(apiClient: APIClientProtocol) {
        self.apiClient = apiClient
    }
    
    func execute(vignettes: [Vignette], vehicleInformation: VehicleInformation) async throws {
        var orders: [PostOrder] = []
        
        for vignette in vignettes {
            orders.append(.init(
                type: vignette.type.rawValue,
                category: vehicleInformation.type,
                cost: Float(vignette.price))
            )
        }
        
        let response: OrderResponse = try await apiClient.request(
            type: .post(OrderRequest(highwayOrders: orders)),
            url: "\(AppConfig.shared.baseUrl)/highway/order"
        )
        
        if let message = response.message, response.statusCode == Constants.error {
            throw SendOrderError.backendError(message)
        }
    }
}

struct SendOrderUseCasePreview: SendOrderUseCaseProtocol {
    func execute(vignettes: [Vignette], vehicleInformation: VehicleInformation) async throws {
        
    }
}
