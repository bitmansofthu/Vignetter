//
//  Vignetter+Factoy.swift
//  Vignetter
//
//  Created by Ferenc Knebl on 2026. 02. 23..
//

import FactoryKit

extension Container {
    var networkClient: Factory<APIClientProtocol> {
        Factory(self) { APIClient() }
    }
    
    var highwayInfoRepository: Factory<HighwayInfoRepositoryProtocol> {
        Factory(self) { HighwayInfoRepository() }
            .scope(.cached)
    }
    
    var getHighwayInfoUseCase: Factory<GetHighwayInfoUseCaseProtocol> {
        Factory(self) { GetHighwayInfoUseCase() }
    }
    
    var getVehicleUseCase: Factory<GetVehicleUseCaseProtocol> {
        Factory(self) { GetVehicleUseCase() }
    }
    
    var sendOrderUseCase: Factory<SendOrderUseCaseProtocol> {
        Factory(self) { SendOrderUseCase() }
    }
}
