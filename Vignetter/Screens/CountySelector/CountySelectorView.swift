//
//  CountySelectorView.swift
//  Vignetter
//
//  Created by Ferenc Knebl on 2026. 02. 20..
//

import SwiftUI

struct CountySelectorView: View {
    
    private enum Constants {
        static let mapWidth: CGFloat = 311
        static let mapHeight: CGFloat = 186
    }
    
    @StateObject private var viewModel: CountySelectorViewModel
    @State private var showValidationError: Bool = false
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
                    
                    nextButton
                }
            }
            .padding(20)
            .scrollIndicators(.hidden)
        }
        .customNavigationTitle(
            title: "countySelector_navigation_title",
            showBackButton: true
        ) {
            self.coordinator.countySelectorAction(.cancelScreen)
        }
        .alert("countySelector_validationError_title", isPresented: $showValidationError, actions: {
            Button("alert_button_ok") { }
        }, message: {
            Text("countySelector_validationError_message")
        })
        .alert("countySelector_fetchError_title", isPresented: $viewModel.showFetchCountiesError, actions: {
            Button("alert_button_ok") { }
        }, message: {
            Text("countySelector_fetchError_message")
        })
        .task {
            await viewModel.fetchCounties()
        }
    }
    
    var mapView: some View {
        ZStack {
            ForEach(viewModel.counties) { county in
                if let mapInfo = county.mapInfo {
                    Image(
                        viewModel.selectedCounties.contains(county) ?
                            mapInfo.selectedImageName :
                            mapInfo.imageName
                    )
                    .resizable()
                } else {
                    EmptyView()
                }
            }
        }
        .aspectRatio(Constants.mapWidth/Constants.mapHeight, contentMode: .fit)
    }
    
    var countyCheckList: some View {
        ForEach(viewModel.counties) { county in
            checkBoxRow(county: county)
                .padding([.bottom], 5)
        }
    }
    
    func checkBoxRow(county: CountyDTO) -> some View {
        HStack {
            CheckBox(isOn: Binding(get: {
                viewModel.selectedCounties.contains(county)
            }, set: { newValue, transaction in
                withTransaction(transaction) {
                    viewModel.selectCounty(select: newValue, county: county)
                }
            }))
            Text(county.name)
                .font(.brand(size: .FontSize.medium, weight: .regular))
                .foregroundStyle(viewModel.selectedCounties.contains(county) ? .grey500 : .navy)
            Spacer()
            Text("\(viewModel.orderInfo.vignette.price) Ft")
                .font(.brand(size: .FontSize.medium, weight: .bold))
                .foregroundStyle(.navy)
        }
    }
    
    var nextButton: some View {
        RoundedButton(title: "button_next", style: .filled) {
            if viewModel.validateSelectedCounties() {
                coordinator.countySelectorAction(.showCheckout(viewModel.orderInfo))
            } else {
                showValidationError = true
            }
        }
        .disabled(viewModel.selectedCounties.isEmpty)
        .opacity(viewModel.selectedCounties.isEmpty ? 0.7 : 1.0)
    }
}

#Preview {
    let coordinator = PreviewCountrySelectorCoordinator()
    CountySelectorView(coordinator: coordinator, viewModel: .preview)
}
