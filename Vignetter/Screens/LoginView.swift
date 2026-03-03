//
//  LoginView.swift
//  Vignetter
//
//  Created by Ferenc Knebl on 2026. 03. 03..
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var appCoordinator: AppCoordinator
    
    @State private var userName: String = ""
    @State private var password: String = ""
    
    var body: some View {
        ZStack {
            Color.lime
                .ignoresSafeArea()
            
            VStack(spacing: 5) {
                Image("logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 281, height: 293)
                
                TextField("User name", text: $userName)
                    .padding(15)
                    .background(textFieldBackground)
                
                TextField("Password", text: $password)
                    .padding(15)
                    .background(textFieldBackground)
                
                Spacer()
                    .frame(height: 10)
                
                RoundedButton(title: "Login", style: .filled) {
                    appCoordinator.setState(.dashboard)
                }
            }
            .padding(.horizontal, 40)
        }
    }
    
    private var textFieldBackground: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(.white)
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.navy)
            }
    }
}

#Preview {
    LoginView()
}
