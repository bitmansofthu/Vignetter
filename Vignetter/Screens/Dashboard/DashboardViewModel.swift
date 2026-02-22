//
//  DashboardViewModel.swift
//  Vignetter
//
//  Created by Ferenc Knebl on 2026. 02. 17..
//

import Combine
import SwiftUI

struct DashboardViewState {
    let vignettes: [Vignette]
    let countyVignette: Vignette?
    let vehicleInformation: VehicleInformation?
}

enum DashboardState {
    case initial
    case loading
    case loaded(_ viewState: DashboardViewState)
    case error(_ message: LocalizedStringKey)
}

class DashboardViewModel: ObservableObject {
    
    // MARK: - Published Properties
    
    @Published var state: DashboardState
    @Published var selectedVignette: Vignette? = nil
    
    // MARK: - Private Properties
    
    private let getHighwayInfoUseCase: GetHighwayInfoUseCaseProtocol
    private let getVehicleUseCase: GetVehicleUseCaseProtocol
    
    // MARK: - Lifecycle
    
    init(
        state: DashboardState = .initial,
        getHighwayInfoUseCase: GetHighwayInfoUseCaseProtocol,
        getVehicleUseCase: GetVehicleUseCaseProtocol
    ) {
        self.state = state
        self.getVehicleUseCase = getVehicleUseCase
        self.getHighwayInfoUseCase = getHighwayInfoUseCase
    }
    
    func fetchData() async {
        state = .loading
        do {
            let info = try await getHighwayInfoUseCase.execute()
            let vehicleInformation = try await getVehicleUseCase.execute()
            
            // Filter yearly vignette, as it is not available in the designs.
            let countryVignettes = info.vignettes.filter {
                $0.type != .year && $0.type != .county
            }
            
            let yearlyCountyVignette = info.vignettes.first {
                $0.type == .county
            }
            
            self.state = .loaded(DashboardViewState(
                vignettes: countryVignettes,
                countyVignette: yearlyCountyVignette,
                vehicleInformation: vehicleInformation)
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
        return DashboardViewModel(
            state: .loaded(.preview),
            getHighwayInfoUseCase: GetHighwayInfoUseCasePreview(),
            getVehicleUseCase: GetVehicleUseCasePreview()
        )
    }()
}

extension DashboardViewState {
    static var preview: DashboardViewState {
        .init(vignettes: [.preview], countyVignette: .preview, vehicleInformation: .preview)
    }
}
#endif
