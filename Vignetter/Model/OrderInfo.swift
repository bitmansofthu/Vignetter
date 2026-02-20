//
//  OrderInfo.swift
//  Vignetter
//
//  Created by Ferenc Knebl on 2026. 02. 20..
//

struct OrderInfo: Hashable {
    let vehicleInformation: VehicleInformation
    let vignette: Vignette
    var counties: [CountyDTO] = []
    
    var summaryPrice: Int {
        // TODO: update for selected countries
        vignette.price + vignette.trxFee
    }
}

extension OrderInfo {
    static var preview: Self {
        .init(vehicleInformation: .preview, vignette: .preview)
    }
}
