//
//  HighwayInfoPayloadDTO.swift
//  Vignetter
//
//  Created by Ferenc Knebl on 2026. 02. 19..
//

struct HighwayInfoPayload: Codable {
    let counties: [CountyDTO]
    let highwayVignettes: [HighwayVignetteDTO]
    let vehicleCategories: [VehicleCategoryDTO]
}
