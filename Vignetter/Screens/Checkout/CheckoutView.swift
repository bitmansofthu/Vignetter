//
//  CheckoutView.swift
//  Vignetter
//
//  Created by Ferenc Knebl on 2026. 02. 19..
//

import SwiftUI

struct CheckoutView: View {
    
    // MARK: - Types
    
    private enum Constants {
        static let spacing: CGFloat = 10
    }
    
    // MARK: - Private Properties
    
    private let coordinator: CheckoutCoordinatorProtocol
    
    @StateObject private var viewModel: CheckoutViewModel
    @State private var isSendingOrder: Bool = false
    
    // MARK: - Lifecycle
    
    init(
        coordinator: CheckoutCoordinatorProtocol,
        viewModel: CheckoutViewModel
    ) {
        self._viewModel = StateObject(wrappedValue: viewModel)
        self.coordinator = coordinator
    }
    
    // MARK: - Body
    
    var body: some View {
        switch viewModel.state {
        case let .info(info):
            infoPhaseView(info: info)
        case .success:
            successPhaseView
        }
    }
    
    func infoPhaseView(info: CheckoutScreenInfo) -> some View {
        ZStack {
            Color.grey50
                .ignoresSafeArea()
            
            detailsView(info: viewModel.info)
        }
        .customNavigationTitle(
            title: "checkout_navigation_title",
            showBackButton: !isSendingOrder
        ) {
            self.coordinator.cancelScreen()
        }
        .alert("checkout_alert_error_title", isPresented: $viewModel.showErrorAlert) {
            Button("alert_button_ok", role: .cancel) { }
        } message: {
            Text(viewModel.errorMessage ?? "")
        }
    }
    
    var successPhaseView: some View {
        EmptyView()
    }
        
    func detailsView(info: CheckoutScreenInfo) -> some View {
        ScrollView {
            VStack(spacing: 0) {
                VStack(spacing: Constants.spacing) {
                    HStack {
                        Text("checkout_title")
                            .font(.brand(size: .FontSize.extraLarge, weight: .bold))
                            .foregroundStyle(.navy)
                            .lineLimit(1)
                        
                        Spacer()
                    }
                    
                    Divider()
                    
                    HStack {
                        Text("checkout_plate")
                            .font(.brand(size: .FontSize.medium))
                            .foregroundStyle(.navy)
                        Spacer()
                        Text(info.vehicleInformation.plate)
                            .font(.brand(size: .FontSize.medium))
                            .foregroundStyle(.navy)
                    }
                    
                    HStack {
                        Text("checkout_vignetterType")
                            .font(.brand(size: .FontSize.medium))
                            .foregroundStyle(.navy)
                        Spacer()
                        Text(info.vignette.name)
                            .font(.brand(size: .FontSize.medium))
                            .foregroundStyle(.navy)
                    }
                }
                .padding([.leading, .trailing], 5)
                
                Divider()
                    .padding([.top, .bottom])
                
                HStack {
                    VStack(
                        alignment: .leading,
                        spacing: 5
                    ) {
                        Text("checkout_summaryPrice")
                            .font(.brand(size: .FontSize.medium, weight: .bold))
                            .foregroundStyle(.navy)
                        Text("\(info.summaryPrice) Ft")
                            .font(.brand(size: .FontSize.ultraLarge, weight: .bold))
                            .foregroundStyle(.navy)
                    }
                    
                    Spacer()
                }
                .padding([.bottom])
                
                if isSendingOrder {
                    HStack {
                        Spacer()
                        ProgressView()
                            .progressViewStyle(.circular)
                            .tint(.navy)
                        Spacer()
                    }
                } else {
                    VStack(spacing: Constants.spacing) {
                        buyButton
                        cancelButton
                    }
                }
            }
            .padding(20)
        }
    }
    
    var buyButton: some View {
        RoundedButton(title: "checkout_buy", style: .filled) {
            Task {
                isSendingOrder = true
                await viewModel.sendOrder()
                isSendingOrder = false
            }
        }
    }
    
    var cancelButton: some View {
        RoundedButton(title: "checkout_cancel") {
            self.coordinator.cancelScreen()
        }
    }
        
}
