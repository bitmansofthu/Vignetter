//
//  CheckBox.swift
//  Vignetter
//
//  Created by Ferenc Knebl on 2026. 02. 18..
//

import SwiftUI

struct CheckBox: View {
    
    private enum Constants {
        static let cornerRadius: CGFloat = 4
    }
    
    @Binding var isOn: Bool
    
    var body: some View {
        Button {
            isOn.toggle()
        } label: {
            HStack(spacing: 0) {
                Image("check")
                    .resizable()
                    .scaledToFit()
                    .opacity(isOn ? 1.0 : 0.0)
                    .frame(width: 12, height: 12)
            }
            .frame(width: 20, height: 20)
            .background(isOn ? Color.grey100 : Color.clear)
            .cornerRadius(Constants.cornerRadius)
            .overlay(
                RoundedRectangle(cornerRadius: Constants.cornerRadius)
                    .stroke(.grey100, lineWidth: 2)
            )
        }
    }
}

#Preview {
    CheckBox(isOn: .constant(false))
}
