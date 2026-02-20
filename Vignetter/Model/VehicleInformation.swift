//
//  VehicleInformation.swift
//  Vignetter
//
//  Created by Ferenc Knebl on 2026. 02. 18..
//

import Foundation

struct VehicleInformation: Hashable {
    
    let name: String
    let plate: String
    let vignetteType: String
    let type: String
    
    init(response: VehicleResponse) {
        self.name = response.name
        self.plate = response.plate
        self.vignetteType = response.vignetteType
        self.type = response.type
    }
    
    init(name: String, plate: String, vignetteType: String, type: String) {
        self.name = name
        self.plate = plate
        self.vignetteType = vignetteType
        self.type = type
    }
    
}
