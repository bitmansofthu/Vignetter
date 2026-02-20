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
    
    let apiClient: APIClientProtocol
    
    init(apiClient: APIClientProtocol) {
        self.apiClient = apiClient
    }
    
    func execute() async throws -> HighwayInfo {
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

struct GetHighwayInfoUseCasePreview: GetHighwayInfoUseCaseProtocol {
    
    func execute() async throws -> HighwayInfo {
        HighwayInfo(vignettes: [], counties: [])
    }
    
}
