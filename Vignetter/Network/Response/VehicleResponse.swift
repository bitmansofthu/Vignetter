//
//  VehicleResponse.swift
//  Vignetter
//
//  Created by Ferenc Knebl on 2026. 02. 19..
//

struct VehicleResponse: Codable {
    let internationalRegistrationCode: String
    let name: String
    let plate: String
    let requestId: Int
    let statusCode: String
    let vignetteType: String
    let type: String
}
