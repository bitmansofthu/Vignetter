//
//  CountrySelectorViewModel.swift
//  Vignetter
//
//  Created by Ferenc Knebl on 2026. 02. 20..
//

import FactoryKit
import Combine

@MainActor
class CountySelectorViewModel: ObservableObject {
    
    // MARK: - Published Properties
    
    @Published var showFetchCountiesError: Bool = false
    @Published var counties: [CountyDTO] = []
    @Published var selectedCounties: Set<CountyDTO> = []
    
    var summaryPrice: Int {
        selectedCounties.count * orderInfo.vignette.price
    }
    
    var orderInfo: OrderInfo
    
    // MARK: - Dependencies
    
    @Injected(\.getHighwayInfoUseCase) var getHighwayInfoUseCase
    
    // MARK: - Lifecycle
    
    init(info: OrderInfo) {
        orderInfo = info
    }
    
    func fetchCounties() async {
        do {
            let info = try await getHighwayInfoUseCase.execute()
            self.counties = info.counties
        } catch {
            showFetchCountiesError = true
        }
    }
    
    func selectCounty(select: Bool, county: CountyDTO) {
        if select {
            selectedCounties.insert(county)
        } else {
            selectedCounties.remove(county)
        }
        orderInfo.counties = Array(selectedCounties)
    }
    
    func validateSelectedCounties() -> Bool {
        guard selectedCounties.count > 1 else {
            return true
        }
        
        let selectedMapInfoCounties = selectedCounties.compactMap { $0.mapInfo }
        var allNeighbours = Set<CountyMapInfo>()
        
        for county in selectedMapInfoCounties {
            allNeighbours.formUnion(county.neighbours)
        }
        
        return allNeighbours.intersection(Set(selectedMapInfoCounties)).count == selectedMapInfoCounties.count
    }
}

#if DEBUG
extension CountySelectorViewModel {
    static let preview: CountySelectorViewModel = {
        let _ = Container.shared.getHighwayInfoUseCase.register { GetHighwayInfoUseCasePreview() }
        return CountySelectorViewModel(
            info: .preview
        )
    }()
}
#endif
