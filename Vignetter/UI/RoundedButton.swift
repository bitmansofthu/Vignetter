//
//  RoundedButton.swift
//  Vignetter
//
//  Created by Ferenc Knebl on 2026. 02. 18..
//

import SwiftUI

enum RoundedButtonStyle {
    case normal
    case filled
}

struct RoundedButton: View {
    
    private enum Constants {
        static let cornerRadius: CGFloat = 24
    }
    
    let title: LocalizedStringKey
    let action: (() -> Void)?
    let style: RoundedButtonStyle
    
    init(
        title: LocalizedStringKey,
        style: RoundedButtonStyle = .normal,
        action: (() -> Void)?
    ) {
        self.title = title
        self.action = action
        self.style = style
    }
    
    var body: some View {
        Button {
            action?()
        } label: {
            HStack(spacing: 0) {
                Spacer()
                Text(title)
                    .foregroundStyle(textColor)
                    .font(.brand(size: .FontSize.medium, weight: .bold))
                Spacer()
            }
        }
        .frame(height: 48)
        .padding(.horizontal)
        .background(backgroundView)
        .cornerRadius(Constants.cornerRadius)
        .overlay(
            RoundedRectangle(cornerRadius: Constants.cornerRadius)
                .stroke(.navy, lineWidth: style == .normal ? 2 : 0)
        )
    }
    
    var textColor: Color {
        switch style {
        case .normal:
            return .navy
        case .filled:
            return .white
        }
    }
    
    var backgroundView: some View {
        switch style {
        case .normal:
            return Color.clear
        case .filled:
            return Color.navy
        }
    }
}
