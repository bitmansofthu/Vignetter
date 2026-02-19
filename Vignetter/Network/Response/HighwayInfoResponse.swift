//
//  HighwayVignetteInformationResponse.swift
//  Vignetter
//
//  Created by Ferenc Knebl on 2026. 02. 19..
//

struct HighwayInfoResponse: Codable {
    let dataType: String
    let payload: HighwayInfoPayload
    let requestId: Int
    let statusCode: String
}
