//
//  BaseCoordinator.swift
//  Vignetter
//
//  Created by Ferenc Knebl on 2026. 02. 18..
//

import Combine
import Foundation
import SwiftUI

enum MainDestination: Hashable {
    case countySelector(_ info: OrderInfo)
    case checkout(_ info: OrderInfo)
}

class MainCoordinator: BaseCoordinator<MainDestination> {
    
    @Published var isSheetPresented: Bool = false
    
    var navigationView: some View {
        ScreenFactory.createDashboard()
            .navigationDestination(for: MainDestination.self) { destination in
                switch destination {
                case let .countySelector(info):
                    ScreenFactory.createCountySelector(info: info)
                case let .checkout(info):
                    ScreenFactory.createCheckout(info: info)
                }
            }
            .id(startID)
    }

    func showCountySelector(orderInfo: OrderInfo) {
        push(destination: .countySelector(orderInfo))
    }
    
    func showCheckout(orderInfo: OrderInfo) {
        push(destination: .checkout(orderInfo))
    }
    
    func showSheet() {
        
    }
}
