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
}

extension OrderInfo {
    static var preview: Self {
        .init(vehicleInformation: .preview, vignette: .preview, counties: [
            .init(id: "YEAR-11", name: "Bács-Kiskun"),
            .init(id: "YEAR-12", name: "Baranya")
        ])
    }
}
