//
//  CountrySelectorViewModel.swift
//  Vignetter
//
//  Created by Ferenc Knebl on 2026. 02. 20..
//

import Combine

class CountySelectorViewModel: ObservableObject {
    
    @Published var showFetchCountiesError: Bool = false
    @Published var showSelectionError: Bool = false
    @Published var counties: [CountyDTO] = []
    @Published var selectedCounties: Set<CountyDTO> = []
    
    var summaryPrice: Int {
        selectedCounties.count * orderInfo.vignette.price
    }
    
    private let orderInfo: OrderInfo
    private let getHighwayInfoUseCase: GetHighwayInfoUseCaseProtocol
    
    init(
        info: OrderInfo,
        getHighwayInfoUseCase: GetHighwayInfoUseCaseProtocol
    ) {
        orderInfo = info
        self.getHighwayInfoUseCase = getHighwayInfoUseCase
    }
    
    func fetchCounties() async {
        do {
            let info = try await getHighwayInfoUseCase.execute()
            self.counties = info.counties
        } catch {
            showFetchCountiesError = true
        }
    }
    
    func toggleSelectCounty(_ county: CountyDTO) {
        if selectedCounties.contains(county) {
            selectedCounties.remove(county)
        } else {
            selectedCounties.insert(county)
        }
    }
}

#if DEBUG
extension CountySelectorViewModel {
    static let preview: CountySelectorViewModel = {
        CountySelectorViewModel(
            info: .preview,
            getHighwayInfoUseCase: GetHighwayInfoUseCasePreview()
        )
    }()
}
#endif
