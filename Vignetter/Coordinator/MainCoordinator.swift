//
//  BaseCoordinator.swift
//  Vignetter
//
//  Created by Ferenc Knebl on 2026. 02. 18..
//

import Combine
import FactoryKit
import Foundation
import SwiftUI

@MainActor
class MainCoordinator: ObservableObject {
    
    @Published var path: NavigationPath = NavigationPath()
    
    enum Destination: Hashable {
        case countySelector(_ info: OrderInfo)
        case checkout(_ info: OrderInfo)
    }
    
    // This can be used to reset the root view StateObject
    private var startID: UUID = UUID()
    
    func startView() -> some View {
        ScreenFactory.createDashboard()
            .navigationDestination(for: Destination.self) { destination in
                switch destination {
                case let .checkout(orderInfo):
                    ScreenFactory.createCheckout(info: orderInfo)
                case let .countySelector(orderInfo):
                    ScreenFactory.createCountySelector(info: orderInfo)
                }
            }
            .id(startID)
    }
    
    func showCountySelector(orderInfo: OrderInfo) {
        path.append(Destination.countySelector(orderInfo))
    }
    
    func showCheckout(orderInfo: OrderInfo) {
        path.append(Destination.checkout(orderInfo))
    }
    
    func goBack() {
        if !path.isEmpty {
            path.removeLast()
        }
    }
    
    func reset() {
        path = NavigationPath()
        startID = UUID()
    }
}
