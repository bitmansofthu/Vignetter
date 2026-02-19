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
}

struct Vignette: Hashable {
    let type: VignetteType
    let price: Int
    
    init(type: VignetteType, price: Int) {
        self.type = type
        self.price = price
    }
    
    var name: LocalizedStringKey {
        switch type {
        case .day:
            return "vignette_type_day"
        case .week:
            return "vignette_type_week"
        case .month:
            return "vignette_type_month"
        case .year:
            return "vignette_type_year"
        }
    }
}
