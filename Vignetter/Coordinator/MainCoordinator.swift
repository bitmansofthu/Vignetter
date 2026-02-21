//
//  BaseCoordinator.swift
//  Vignetter
//
//  Created by Ferenc Knebl on 2026. 02. 18..
//

import Foundation
import Combine
import SwiftUI

class MainCoordinator: ObservableObject {
    
    @Published var path: NavigationPath = NavigationPath()
    
    enum Destination: Hashable {
        case countySelector(_ info: OrderInfo)
        case checkout(_ info: OrderInfo)
    }

    private let getHighwayInfoUseCase: GetHighwayInfoUseCaseProtocol
    private let getVehicleUseCase: GetVehicleUseCaseProtocol
    private let sendOrderUseCase: SendOrderUseCaseProtocol
    
    // This can be used to reset the root view StateObject
    private var startID: UUID = UUID()
    
    init(
        getHighwayInfoUseCase: GetHighwayInfoUseCaseProtocol,
        getVehicleUseCase: GetVehicleUseCaseProtocol,
        sendOrderUseCase: SendOrderUseCaseProtocol
    ) {
        self.getHighwayInfoUseCase = getHighwayInfoUseCase
        self.getVehicleUseCase = getVehicleUseCase
        self.sendOrderUseCase = sendOrderUseCase
    }
    
    func startView() -> some View {
        ScreenFactory.createDashboard(
            coordinator: self,
            getHighwayInfoUseCase: getHighwayInfoUseCase,
            getVehicleUseCase: getVehicleUseCase
        )
        .navigationDestination(for: Destination.self) { destination in
            switch destination {
            case let .checkout(info):
                ScreenFactory.createCheckout(
                    coordinator: self,
                    info: info,
                    sendOrderUseCase: self.sendOrderUseCase
                )
            case let .countySelector(info):
                ScreenFactory.createCountySelector(
                    coordinator: self,
                    info: info,
                    getHighwayInfoUseCase: self.getHighwayInfoUseCase
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
