//
//  NewHighwayInfoRepository.swift
//  Vignetter
//
//  Created by Ferenc Knebl on 2026. 02. 21..
//

protocol HighwayInfoRepositoryProtocol {
    func getHighwayInfo() async throws -> HighwayInfo
}

class HighwayInfoRepository: HighwayInfoRepositoryProtocol {
    
    private var highwayInfo: HighwayInfo? = nil
    private let apiClient: APIClientProtocol
    
    init(apiClient: APIClientProtocol) {
        self.apiClient = apiClient
    }
    
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
            url: "\(AppConfig.shared.baseUrl)/highway/info"
        )
        
        var vignettes = [Vignette]()
        for vignette in response.payload.highwayVignettes {
            if let vignetteRawType = vignette.vignetteType.first,
                let vignetteType = VignetteType(rawValue: vignetteRawType) {
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
