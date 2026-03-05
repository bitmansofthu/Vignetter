//
//  DashboardViewModel.swift
//  Vignetter
//
//  Created by Ferenc Knebl on 2026. 02. 17..
//

import Combine
import FactoryKit
import SwiftUI

struct DashboardViewState {
    let vignettes: [Vignette]
    let countyVignette: Vignette?
    let vehicleInformation: VehicleInformation?
}

enum DashboardState {
    case loading
    case loaded(_ viewState: DashboardViewState)
    case error(_ message: LocalizedStringKey)
}

@MainActor
class DashboardViewModel: ObservableObject {
    
    // MARK: - Published Properties
    
    @Published var state: DashboardState
    @Published var selectedVignette: Vignette? = nil
    
    // MARK: - Dependencies
    
    @Injected(\.getHighwayInfoUseCase) var getHighwayInfoUseCase
    @Injected(\.getVehicleUseCase) var getVehicleUseCase
    
    private var group: TaskGroup<String>? = nil
    
    // MARK: - Lifecycle
    
    init(
        state: DashboardState = .loading,
    ) {
        self.state = state
    }
    
    func fetchData() async {
        state = .loading
        do {
            async let info = try getHighwayInfoUseCase.execute()
            async let vehicleInformation = try getVehicleUseCase.execute()
            
            // Filter yearly vignette, as it is not available in the designs.
            self.state = await .loaded(DashboardViewState(
                vignettes: try info.vignettes.filter {
                    $0.type != .year && $0.type != .county
                },
                countyVignette: try info.vignettes.first {
                    $0.type == .county
                },
                vehicleInformation: try vehicleInformation)
            )
        } catch {
            self.state = .error("dashboard_error_message")
        }
    }
    
    func selectVignette(_ vignette: Vignette) {
        self.selectedVignette = vignette
    }
}

#if DEBUG
extension DashboardViewModel {
    static let preview: DashboardViewModel = {
        let _ = Container.shared.getVehicleUseCase.register { GetVehicleUseCasePreview() }
        let _ = Container.shared.getHighwayInfoUseCase.register { GetHighwayInfoUseCasePreview() }
        return DashboardViewModel(
            state: .loaded(.preview)
        )
    }()
}

extension DashboardViewState {
    static var preview: DashboardViewState {
        .init(vignettes: [.preview], countyVignette: .preview, vehicleInformation: .preview)
    }
}
#endif
