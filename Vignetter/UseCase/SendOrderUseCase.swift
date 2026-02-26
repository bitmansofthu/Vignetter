//
//  SendOrderUseCase.swift
//  Vignetter
//
//  Created by Ferenc Knebl on 2026. 02. 20..
//

import FactoryKit
import Foundation

protocol SendOrderUseCaseProtocol {
    func execute(vignette: Vignette, counties: [CountyDTO], vehicleInformation: VehicleInformation) async throws
}

enum SendOrderError: Error, LocalizedError {
    case backendError(_ message: String)
}

struct SendOrderUseCase: SendOrderUseCaseProtocol {
    
    private enum Constants {
        static let error = "ERROR"
        static let ok = "OK"
    }
    
    @Injected(\.networkClient) var apiClient
    
    func execute(
        vignette: Vignette,
        counties: [CountyDTO],
        vehicleInformation: VehicleInformation
    ) async throws {
        var orders: [PostOrder] = []
        
        if vignette.type == .county {
            for county in counties {
                orders.append(.init(
                    type: county.id,
                    category: vehicleInformation.type,
                    cost: Float(vignette.price))
                )
            }
        } else {
            orders = [PostOrder(
                type: vignette.type.rawValue,
                category: vehicleInformation.type,
                cost: Float(vignette.price))
            ]
        }
        
        let response: OrderResponse = try await apiClient.request(
            type: .post(OrderRequest(highwayOrders: orders)),
            endpoint: "/highway/order"
        )
        
        if let message = response.message, response.statusCode == Constants.error {
            throw SendOrderError.backendError(message)
        }
    }
}

struct SendOrderUseCasePreview: SendOrderUseCaseProtocol {
    func execute(vignette: Vignette, counties: [CountyDTO], vehicleInformation: VehicleInformation) async throws {
        
    }
}
