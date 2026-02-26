//
//  NewHighwayInfoRepository.swift
//  Vignetter
//
//  Created by Ferenc Knebl on 2026. 02. 21..
//

import FactoryKit

protocol HighwayInfoRepositoryProtocol {
    func getHighwayInfo() async throws -> HighwayInfo
}

actor HighwayInfoRepository: HighwayInfoRepositoryProtocol {
    
    @Injected(\.networkClient) var apiClient
    private var highwayInfo: HighwayInfo? = nil
    
    func getHighwayInfo() async throws -> HighwayInfo {
        if let highwayInfo {
            // TODO: check expiration
            return highwayInfo
        } else {
            let info = try await fetchHighwayInfo()
            highwayInfo = info
            return info
        }
    }
    
    private func fetchHighwayInfo() async throws -> HighwayInfo {
        let response: HighwayInfoResponse = try await apiClient.request(
            type: .get,
            endpoint: "/highway/info"
        )
        
        var vignettes = [Vignette]()
        for vignette in response.payload.highwayVignettes {
            if let vignetteRawType = vignette.vignetteType.first,
               let vignetteType = VignetteType.from(rawString: vignetteRawType) {
                vignettes.append(
                    Vignette(
                        type: vignetteType,
                        price: vignette.cost,
                        trxFee: vignette.trxFee
                    )
                )
            }
        }
        
        return HighwayInfo(
            vignettes: vignettes,
            counties: response.payload.counties
        )
    }
    
}
