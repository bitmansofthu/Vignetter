//
//  HighwayVignette.swift
//  Vignetter
//
//  Created by Ferenc Knebl on 2026. 02. 18..
//

import Foundation
import SwiftUI

enum VignetteType: String {
    case day = "DAY"
    case week = "WEEK"
    case month = "MONTH"
    case year = "YEAR"
    case county = "YEAR_"
    
    static func from(rawString: String) -> VignetteType? {
        if rawString.hasPrefix(VignetteType.county.rawValue) {
            return .county
        }
        return VignetteType(rawValue: rawString)
    }
    
    var name: LocalizedStringKey {
        switch self {
        case .day:
            return "vignette_type_day"
        case .week:
            return "vignette_type_week"
        case .month:
            return "vignette_type_month"
        case .year:
            return "vignette_type_year"
        case .county:
            return "vignette_type_county"
        }
    }
}

struct Vignette: Hashable {
    let type: VignetteType
    let price: Int
    let trxFee: Int
    
    init(type: VignetteType, price: Int, trxFee: Int) {
        self.type = type
        self.price = price
        self.trxFee = trxFee
    }
}

extension Vignette {
    static var preview: Vignette {
        .init(type: .day, price: 1000, trxFee: 200)
    }
}
