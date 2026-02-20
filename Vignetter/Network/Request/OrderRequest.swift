//
//  OrderRequest.swift
//  Vignetter
//
//  Created by Ferenc Knebl on 2026. 02. 20..
//

import Foundation

struct OrderRequest: Codable {
    let highwayOrders: [PostOrder]
}

struct PostOrder: Codable {
    let type: String
    let category: String
    let cost: Float

    init(type: String, category: String, cost: Float) {
        self.type = type
        self.category = category
        self.cost = cost
    }
}
