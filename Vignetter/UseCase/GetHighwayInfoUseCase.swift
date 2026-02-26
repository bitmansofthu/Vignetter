//
//  GetHighwayInfoUseCase.swift
//  Vignetter
//
//  Created by Ferenc Knebl on 2026. 02. 19..
//

import FactoryKit

protocol GetHighwayInfoUseCaseProtocol {
    func execute() async throws -> HighwayInfo
}

struct GetHighwayInfoUseCase: GetHighwayInfoUseCaseProtocol {
    
    @Injected(\.highwayInfoRepository) var highwayInfoRepository
    
    func execute() async throws -> HighwayInfo {
        try await highwayInfoRepository.getHighwayInfo()
    }
    
}

struct GetHighwayInfoUseCasePreview: GetHighwayInfoUseCaseProtocol {
    
    func execute() async throws -> HighwayInfo {
        .preview
    }
    
}
