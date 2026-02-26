//
//  CheckoutView.swift
//  Vignetter
//
//  Created by Ferenc Knebl on 2026. 02. 19..
//

import FactoryKit
import SwiftUI

struct CheckoutView: View {
    
    // MARK: - Types
    
    private enum Constants {
        static let spacing: CGFloat = 10
    }
    
    // MARK: - Private Properties
    
    @StateObject private var viewModel: CheckoutViewModel
    @State private var isSendingOrder: Bool = false
    
    // MARK: - Dependencies
    
    @EnvironmentObject var mainCoordinator: MainCoordinator
    
    // MARK: - Lifecycle
    
    init(
        viewModel: CheckoutViewModel
    ) {
        self._viewModel = StateObject(wrappedValue: viewModel)
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
    
    func infoPhaseView(info: OrderInfo) -> some View {
        ZStack {
            Color.grey50
                .ignoresSafeArea()
            
            detailsView(info: viewModel.info)
        }
        .customNavigationTitle(
            title: "checkout_navigation_title",
            showBackButton: !isSendingOrder
        ) {
            mainCoordinator.goBack()
        }
        .alert("checkout_alert_error_title", isPresented: $viewModel.showErrorAlert) {
            Button("alert_button_ok", role: .cancel) { }
        } message: {
            Text(viewModel.errorMessage ?? "")
        }
    }
    
    var successPhaseView: some View {
        CheckoutSuccessView()
    }
        
    func detailsView(info: OrderInfo) -> some View {
        VStack {
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
                            Text(info.vignette.type.name)
                                .font(.brand(size: .FontSize.medium))
                                .foregroundStyle(.navy)
                        }
                        
                        if !info.counties.isEmpty {
                            Divider()
                            
                            selectedCounties(info: info)
                        }
                        
                        HStack {
                            Text("checkout_trxfee")
                                .font(.brand(size: .FontSize.small))
                                .foregroundStyle(.navy)
                            Spacer()
                            Text("\(info.vignette.trxFee) Ft")
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
                            Text("\(viewModel.summaryPrice) Ft")
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
                    }
                }
                .padding(20)
            }
            
            if !isSendingOrder {
                VStack(spacing: Constants.spacing) {
                    buyButton
                    cancelButton
                }
                .padding()
            }
        }
    }
    
    func infoRow(title: LocalizedStringKey, value: String) -> some View {
        HStack {
            Text(title)
                .font(.brand(size: .FontSize.medium))
                .foregroundStyle(.navy)
            Spacer()
            Text(value)
                .font(.brand(size: .FontSize.medium))
                .foregroundStyle(.navy)
        }
    }
    
    func selectedCounties(info: OrderInfo) -> some View {
        ForEach(info.counties) { county in
            HStack {
                Text(county.name)
                    .font(.brand(size: .FontSize.medium, weight: .bold))
                    .foregroundStyle(.navy)
                Spacer()
                Text("\(info.vignette.price) Ft")
                    .font(.brand(size: .FontSize.medium))
                    .foregroundStyle(.navy)
            }
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
            mainCoordinator.goBack()
        }
    }
        
}

#Preview {
    CheckoutView(viewModel: .preview)
}
