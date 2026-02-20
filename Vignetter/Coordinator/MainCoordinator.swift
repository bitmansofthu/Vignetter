//
//  BaseCoordinator.swift
//  Vignetter
//
//  Created by Ferenc Knebl on 2026. 02. 18..
//

import Foundation
import Combine
import SwiftUI

protocol DashboardCoordinatorProtocol {
    func showCheckout(info: CheckoutScreenInfo)
    func showCountySelector()
}

protocol CheckoutCoordinatorProtocol {
    func cancelScreen()
    func goToDashboard()
}

class MainCoordinator: ObservableObject {
    
    @Published var path: NavigationPath = NavigationPath()
    
    enum Destination: Hashable {
        case countySelector
        case checkout(_ info: CheckoutScreenInfo)
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
            case .countySelector:
                ScreenFactory.createCountySelector(coordinator: self)
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

extension MainCoordinator: DashboardCoordinatorProtocol {
    func showCheckout(info: CheckoutScreenInfo) {
        path.append(Destination.checkout(info))
    }
    
    func showCountySelector() {
        
    }
}

extension MainCoordinator: CheckoutCoordinatorProtocol {
    func cancelScreen() {
        goBack()
    }
    
    func goToDashboard() {
        reset()
    }
}

// MARK: - Previews

class PreviewDashboardCoordinator: DashboardCoordinatorProtocol {
    func showCheckout(info: CheckoutScreenInfo) {
        
    }
    
    func showCountySelector() {
        
    }
}

class PreviewCheckoutCoordinator: CheckoutCoordinatorProtocol {    
    func cancelScreen() {
        
    }
    
    func goToDashboard() {
        
    }
}
