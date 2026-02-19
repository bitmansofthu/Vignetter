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
    func showCheckout()
    func showCountySelector()
}

class MainCoordinator: ObservableObject {
    
    @Published var path: NavigationPath = NavigationPath()
    
    enum Destination: Hashable {
        case countySelector
        case checkout
    }

    private let getHighwayInfoUseCase: GetHighwayInfoUseCaseProtocol
    private let getVehicleUseCase: GetVehicleUseCaseProtocol
    
    init(apiClient: APIClientProtocol) {
        getHighwayInfoUseCase = GetHighwayInfoUseCase(apiClient: apiClient)
        getVehicleUseCase = GetVehicleUseCase(apiClient: apiClient)
    }
    
    func startView() -> some View {
        ScreenFactory.createDashboard(
            coordinator: self,
            getHighwayInfoUseCase: getHighwayInfoUseCase,
            getVehicleUseCase: getVehicleUseCase
        )
        .navigationDestination(for: Destination.self) { destination in
            switch destination {
            case .checkout:
                ScreenFactory.createCheckout(coordinator: self)
            case .countySelector:
                ScreenFactory.createCountySelector(coordinator: self)
            }
        }
    }
    
    func goBack() {
        if !path.isEmpty {
            path.removeLast()
        }
    }
    
    func clearPath() {
        path = NavigationPath()
    }
}

extension MainCoordinator: DashboardCoordinatorProtocol {
    func showCheckout() {
        path.append(Destination.checkout)
    }
    
    func showCountySelector() {
        
    }
}

class PreviewDashboardCoordinator: DashboardCoordinatorProtocol {
    func showCheckout() {
        
    }
    
    func showCountySelector() {
        
    }
}
