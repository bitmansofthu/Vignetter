//
//  CountySelectorView.swift
//  Vignetter
//
//  Created by Ferenc Knebl on 2026. 02. 20..
//

import SwiftUI

struct CountySelectorView: View {
    
    @StateObject private var viewModel: CountySelectorViewModel
    private let coordinator: CountySelectorCoordinatorProtocol
    
    init(coordinator: CountySelectorCoordinatorProtocol, viewModel: CountySelectorViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
        self.coordinator = coordinator
    }
    
    var body: some View {
        ZStack {
            Color.grey50
                .ignoresSafeArea()
            
            ScrollView {
                VStack {
                    HStack {
                        Text("countySelector_title")
                            .font(.brand(size: .FontSize.extraLarge, weight: .bold))
                            .foregroundStyle(.navy)
                            .lineLimit(1)
                        Spacer()
                    }
                    
                    mapView
                    
                    countyCheckList
                    
                    Divider()
                        .padding([.top, .bottom])
                    
                    HStack {
                        VStack(alignment: .leading) {
                            Text("countySelector_summaryPrice")
                                .font(.brand(size: .FontSize.medium, weight: .bold))
                                .foregroundStyle(.navy)
                                .lineLimit(1)
                            Text("\(viewModel.summaryPrice) Ft")
                                .font(.brand(size: .FontSize.ultraLarge, weight: .bold))
                                .foregroundStyle(.navy)
                                .lineLimit(1)
                        }
                        Spacer()
                    }
                }
            }
            .padding()
        }
        .customNavigationTitle(
            title: "countySelector_navigation_title",
            showBackButton: true
        ) {
            self.coordinator.countySelectorAction(.cancelScreen)
        }
        .task {
            await viewModel.fetchCounties()
        }
    }
    
    var mapView: some View {
        EmptyView()
    }
    
    var countyCheckList: some View {
        ForEach(viewModel.counties) { county in
            checkBoxRow(county: county)
                .padding([.bottom], 5)
        }
    }
    
    func checkBoxRow(county: CountyDTO) -> some View {
        EmptyView()
    }
}

#Preview {
    let coordinator = PreviewCountrySelectorCoordinator()
    CountySelectorView(coordinator: coordinator, viewModel: .preview)
}
