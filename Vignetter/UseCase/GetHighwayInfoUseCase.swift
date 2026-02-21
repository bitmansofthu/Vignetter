//
//  GetHighwayInfoUseCase.swift
//  Vignetter
//
//  Created by Ferenc Knebl on 2026. 02. 19..
//

protocol GetHighwayInfoUseCaseProtocol {
    func execute() async throws -> HighwayInfo
}

struct GetHighwayInfoUseCase: GetHighwayInfoUseCaseProtocol {
    
    let highwayInfoRepository: HighwayInfoRepositoryProtocol
    
    init(highwayInfoRepository: HighwayInfoRepositoryProtocol) {
        self.highwayInfoRepository = highwayInfoRepository
    }
    
    func execute() async throws -> HighwayInfo {
        try await highwayInfoRepository.getHighwayInfo()
    }
    
}

struct GetHighwayInfoUseCasePreview: GetHighwayInfoUseCaseProtocol {
    
    func execute() async throws -> HighwayInfo {
        .preview
    }
    
}
