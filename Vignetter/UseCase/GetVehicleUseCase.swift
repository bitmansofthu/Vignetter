//
//  GetVehicleUseCase.swift
//  Vignetter
//
//  Created by Ferenc Knebl on 2026. 02. 19..
//

import FactoryKit

protocol GetVehicleUseCaseProtocol {
    func execute() async throws -> VehicleInformation
}

struct GetVehicleUseCase: GetVehicleUseCaseProtocol {
    
    @Injected(\.networkClient) var apiClient
    
    func execute() async throws -> VehicleInformation {
        let response: VehicleResponse = try await apiClient.request(
            type: .get,
            url: "\(AppConfig.shared.baseUrl)/highway/vehicle"
        )
        
        return VehicleInformation(response: response)
    }
    
}

struct GetVehicleUseCasePreview: GetVehicleUseCaseProtocol {
    
    func execute() async throws -> VehicleInformation {
        VehicleInformation(
            name: "Sample Car", plate: "AAA-123", vignetteType: "D1", type: "Private"
        )
    }
    
}
