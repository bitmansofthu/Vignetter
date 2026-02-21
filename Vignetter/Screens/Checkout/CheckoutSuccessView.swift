//
//  Success.swift
//  Vignetter
//
//  Created by Ferenc Knebl on 2026. 02. 20..
//

import SwiftUI

struct CheckoutSuccessView: View {
    
    //MARK: - Types
    
    private enum Constants {
        static let confettiStartPos: CGFloat = -330
        static let containerPadding: CGFloat = 16
    }
    
    
    //MARK: - Public Properties
    
    let coordinator: CheckoutCoordinatorProtocol
    
    //MARK: - Private Properties
    
    @State private var confettiYOffset = Constants.confettiStartPos
    @State private var opacity: CGFloat = 0
    
    //MARK: - Lifecycle
        
    var body: some View {
        ZStack {
            Color.lime
                .ignoresSafeArea()
            
            confetti
                .opacity(opacity)
            
            messageWithLogo
            
            doneButton
        }
        .navigationBarHidden(true)
        .onAppear {
            withAnimation(.easeOut(duration: 0.7)) {
                confettiYOffset = 0
                opacity = 1.0
            }
        }
    }
    
    var confetti: some View {
        VStack {
            Image("confetti")
                .resizable()
                .scaledToFit()
                .offset(y: confettiYOffset)
            Spacer()
        }
    }
    
    var messageWithLogo: some View {
        VStack(spacing: 5) {
            HStack {
                Text("success_title")
                    .font(.brand(size: .FontSize.ultraLarge, weight: .bold))
                    .foregroundStyle(.navy)
                    .lineLimit(3)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: 301)
                Spacer()
            }
            HStack {
                Spacer()
                Image("logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 281, height: 293)
                    .offset(x: 24)
                    .opacity(opacity)
            }
            Spacer()
        }
        .padding(.top, 210)
    }
    
    var doneButton: some View {
        VStack {
            Spacer()
            RoundedButton(title: "checkout_done_button", style: .filled) {
                coordinator.checkoutAction(.gotoDashboard)
            }
            .padding([.leading, .trailing], Constants.containerPadding)
            .padding(.bottom, 34)
        }
    }
}

#Preview {
    let coordinator = PreviewCheckoutCoordinator()
    CheckoutSuccessView(coordinator: coordinator)
}
