//
//  CountrySelectorViewModel.swift
//  Vignetter
//
//  Created by Ferenc Knebl on 2026. 02. 20..
//

import Combine

class CountySelectorViewModel: ObservableObject {
    
    var orderInfo: OrderInfo
    
    init(info: OrderInfo) {
        orderInfo = info
    }
    
}
