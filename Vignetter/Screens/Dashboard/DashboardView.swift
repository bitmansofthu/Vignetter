//
//  ContentView.swift
//  Vignetter
//
//  Created by Ferenc Knebl on 2026. 02. 17..
//

import SwiftUI

struct DashboardView: View {
    
    // MARK: - Types
    
    private enum Constants {
        static let vehicleContainerRadius: CGFloat = 8
        static let containerRadius: CGFloat = 16
        static let cariconSize: CGFloat = 24
        static let cardSpacing: CGFloat = 20
        static let containerPadding: CGFloat = 20
        static let disabledOpacity = 0.7
    }
    
    // MARK: - Private Properties
    
    private let coordinator: DashboardCoordinatorProtocol
    
    @StateObject private var viewModel: DashboardViewModel
    
    // MARK: - Lifecycle
    
    init(coordinator: DashboardCoordinatorProtocol, viewModel: DashboardViewModel) {
        self.coordinator = coordinator
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            Color.grey50
                .ignoresSafeArea()
            
            switch viewModel.state {
            case .initial:
                empty
            case .loading:
                loading
            case let .loaded(viewState):
                content(viewState: viewState)
            case let .error(message):
                errorView(message: message)
            }
        }
        .customNavigationTitle(title: "dashboard_navigation_title")
        .task {
            if case .initial = viewModel.state {
                await viewModel.fetchData()
            }
        }
    }
    
    private var empty: some View {
        VStack {
            Spacer()
        }
    }
    
    private func content(viewState: DashboardViewState) -> some View {
        ScrollView {
            VStack(spacing: Constants.cardSpacing) {
                if let vehicleInfo = viewState.vehicleInformation {
                    vehicleInfoView(vehicleInfo: vehicleInfo)
                        .padding([.leading, .trailing], Constants.containerPadding)
                }
                
                VStack {
                    vignetteListTitle
                    vignetteList(vignettes: viewState.vignettes)
                    
                    buyButton {
                        buyAction(
                            selectedVignette: viewModel.selectedVignette,
                            vehicleInformation: viewState.vehicleInformation
                        )
                    }
                }
                .background {
                    Color.white
                }
                .cornerRadius(Constants.containerRadius)
                .padding([.leading, .trailing], Constants.containerPadding)
                
                if viewState.yearlyCountyVignette != nil {
                    countySelector
                        .padding([.leading, .trailing], Constants.containerPadding)
                }
            }
            .padding(.top, Constants.containerPadding)
        }
    }
    
    private var loading: some View {
        VStack() {
            ProgressView()
                .progressViewStyle(.circular)
                .tint(.navy)
                .padding()
        }
    }
    
    private func errorView(message: LocalizedStringKey) -> some View {
        VStack(spacing: Constants.cardSpacing) {
            Text("dashboard_error_title")
                .font(.brand(size: .FontSize.extraLarge, weight: .semibold))
                .foregroundStyle(.navy)
                .lineLimit(1)
            Text(message)
                .lineLimit(.zero)
                .font(.brand(size: .FontSize.medium, weight: .regular))
                .foregroundStyle(.navy)
            
            RoundedButton(title: "button_retry", style: .filled) {
                Task {
                    await viewModel.fetchData()
                }
            }
        }
        .padding()
    }
    
    private var vignetteListTitle: some View {
        VStack {
            HStack {
                Text("dashboard_country_vignettes")
                    .font(.brand(size: .FontSize.extraLarge, weight: .bold))
                    .foregroundStyle(.navy)
                    .lineLimit(1)
                Spacer()
            }
            .padding()
        }
    }
    
    private func vignetteList(vignettes: [Vignette]) -> some View {
        ForEach(vignettes, id: \.self) { vignette in
            HStack {
                vignetteRow(vignette, selectedVignette: viewModel.selectedVignette)
            }
            .padding([.leading, .trailing])
            .contentShape(RoundedRectangle(cornerSize: .zero))
            .onTapGesture {
                viewModel.selectVignette(vignette)
            }
        }
    }
    
    private func vignetteRow(_ vignette: Vignette, selectedVignette: Vignette?) -> some View {
        HStack {
            Circle()
                .stroke(.grey100, lineWidth: 2)
                .frame(width: 24, height: 24)
                .overlay {
                    Circle()
                        .frame(width: 16, height: 16)
                        .foregroundStyle(selectedVignette == vignette ? .navy : .white)
                }
            
            Text(vignette.name)
                .font(.brand(size: .FontSize.medium, weight: .regular))
                .foregroundStyle(.navy)
                .lineLimit(1)
            Spacer()
            Text("\(vignette.price) Ft")
                .font(.brand(size: .FontSize.medium, weight: .bold))
                .foregroundStyle(.navy)
                .lineLimit(1)
        }
        .padding()
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(selectedVignette == vignette ? .navy : .grey100, lineWidth: 2)
        )
    }
    
    private func buyButton(action: @escaping () -> Void) -> some View {
        RoundedButton(title: "dashboard_button_buy", style: .filled) {
            action()
        }
        .disabled(viewModel.selectedVignette == nil)
        .opacity(viewModel.selectedVignette == nil ? Constants.disabledOpacity : 1.0)
        .padding()
    }
    
    private var countySelector: some View {
        HStack {
            Text("dashboard_button_countySelector")
                .font(.brand(size: .FontSize.large, weight: .bold))
                .foregroundStyle(.navy)
                .lineLimit(1)
                .padding()
            Spacer()
            Image("chevronRight")
                .padding()
        }
        .cornerRadius(Constants.containerRadius)
        .background {
            Color.white
        }
        .cornerRadius(Constants.containerRadius)
        .onTapGesture {
            coordinator.showCountySelector()
        }
    }
    
    private func vehicleInfoView(vehicleInfo: VehicleInformation) -> some View {
        HStack {
            Image("car")
                .resizable()
                .frame(width: Constants.cariconSize, height: Constants.cariconSize)
                .padding([.leading])
            
            VStack(alignment: .leading, content: {
                Text(vehicleInfo.plate)
                    .font(.brand(size: .FontSize.large))
                    .foregroundStyle(.navy)
                Text(vehicleInfo.name)
                    .font(.brand(size: .FontSize.medium, weight: .light))
                    .foregroundStyle(.navy)
            })
            .padding([.top, .bottom])
            Spacer()
        }
        .background {
            Color.white
        }
        .cornerRadius(Constants.vehicleContainerRadius)
    }
    
    private func buyAction(
        selectedVignette: Vignette?,
        vehicleInformation: VehicleInformation?
    ) {
        guard let selectedVignette = viewModel.selectedVignette,
            let vehicleInformation else {
            return
        }
        
        coordinator.showCheckout(info:
            CheckoutScreenInfo(
                vehicleInformation: vehicleInformation,
                vignette: selectedVignette
            )
        )
    }
}

#Preview {
    let coordinator = PreviewDashboardCoordinator()
    DashboardView(coordinator: coordinator, viewModel: .previewLoading)
}
