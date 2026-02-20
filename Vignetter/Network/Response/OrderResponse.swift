//
//  OrderResponse.swift
//  Vignetter
//
//  Created by Ferenc Knebl on 2026. 02. 20..
//

struct OrderResponse: Codable {
    let statusCode: String
    let receivedOrders: [OrderResponseDetails]?
    let message: String?
}

struct OrderResponseDetails: Codable {
    let type: String
    let category: String
    let cost: Float
}
