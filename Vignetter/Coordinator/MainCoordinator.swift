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
        ScreenFactory.createDashboard(
            coordinator: self
        )
        .navigationDestination(for: Destination.self) { destination in
            switch destination {
            case let .checkout(info):
                ScreenFactory.createCheckout(
                    coordinator: self,
                    info: info
                )
            case let .countySelector(info):
                ScreenFactory.createCountySelector(
                    coordinator: self,
                    info: info
                )
            }
        }
        .id(startID)
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
