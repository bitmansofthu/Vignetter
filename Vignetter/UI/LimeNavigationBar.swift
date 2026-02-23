//
//  CustomNavigationBar.swift
//  Vignetter
//
//  Created by Ferenc Knebl on 2026. 02. 23..
//

import SwiftUI

struct LimeNavigationBar: View {
    
    private enum Constants {
        static let cornerRadius: CGFloat = 20
        static let height: CGFloat = 72
    }
    
    private let title: String
    private let showBackArrow: Bool
    private let backAction: (() -> Void)?
    
    init(
        title: String,
        showBackArrow: Bool = false,
        backAction: (() -> Void)? = nil
    ) {
        self.title = title
        self.showBackArrow = showBackArrow
        self.backAction = backAction
    }
    
    var body: some View {
        ZStack {
            backgroundView
                .ignoresSafeArea()
            
            HStack(spacing: 5) {
                if showBackArrow {
                    backArrow
                }
                
                Text(title)
                    .font(.brand(size: .FontSize.large, weight: .bold))
                    .foregroundStyle(.navy)
                
                Spacer()
            }
            .padding(.horizontal, 32)
        }
        .frame(height: Constants.height)
    }
    
    private var backgroundView: some View {
        UnevenRoundedRectangle(
            bottomLeadingRadius: Constants.cornerRadius,
            bottomTrailingRadius: Constants.cornerRadius
        )
        .fill(.lime)
    }
    
    private var backArrow: some View {
        Button {
            backAction?()
        } label: {
            Image("arrowLeft")
                .resizable()
                .frame(width: 24, height: 24)
        }
    }
}

#Preview {
    LimeNavigationBar(
        title: "Test",
        showBackArrow: true,
        backAction: nil
    )
}
