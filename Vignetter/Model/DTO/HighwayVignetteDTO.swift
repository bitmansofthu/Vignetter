//
//  HighwayVignetteDTO.swift
//  Vignetter
//
//  Created by Ferenc Knebl on 2026. 02. 19..
//

struct HighwayVignetteDTO: Codable {
    let cost: Int
    let sum: Int
    let trxFee: Int
    let vehicleCategory: String
    let vignetteType: [String]
}
