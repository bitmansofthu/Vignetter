//
//  View+Modifier.swift
//  Vignetter
//
//  Created by Ferenc Knebl on 2026. 02. 19..
//

import SwiftUI

struct NavigationTitleModifier: ViewModifier {
    
    private let color: Color
    private let title: LocalizedStringKey
    private let showBackButton: Bool
    private let backAction: (() -> Void)?
    
    init(
        title: LocalizedStringKey,
        color: Color,
        showBackButton: Bool,
        backAction: (() -> Void)?
    ) {
        self.color = color
        self.title = title
        self.showBackButton = showBackButton
        self.backAction = backAction
    }
    
    func body(content: Content) -> some View {
        content
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden()
            .toolbarBackground(.lime, for: .navigationBar)
            .toolbarColorScheme(.light, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbar {
                if showBackButton {
                    if #available(iOS 26.0, *) {
                        backToolbarItem
                            .sharedBackgroundVisibility(.hidden)
                    } else {
                        backToolbarItem
                    }
                }
                
                ToolbarItem(placement: .principal) {
                    Text(title)
                        .foregroundColor(.navy)
                }
            }
    }
    
    private var backToolbarItem: some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            Button {
                backAction?()
            } label: {
                Image("arrowLeft")
            }
        }
    }
}

struct LimeNavigationBarModifier: ViewModifier {

    let title: String
    let showBackArrow: Bool
    let backAction: (() -> Void)?
    
    func body(content: Content) -> some View {
        VStack(spacing: 0) {
            LimeNavigationBar(title: title, showBackArrow: showBackArrow, backAction: backAction)
            content
                .navigationBarHidden(true)
        }
    }
}

extension View {
    func customNavigationTitle(
        title: LocalizedStringKey,
        color: Color = .navy,
        showBackButton: Bool = false,
        backAction: (() -> Void)? = nil
    ) -> some View {
        modifier(NavigationTitleModifier(
            title: title,
            color: color,
            showBackButton: showBackButton,
            backAction: backAction
        ))
    }
    
    func limeNavigationBar(
        title: String,
        backgroundColor: Color = .grey50,
        showBackArrow: Bool = false,
        backAction: (() -> Void)? = nil
    ) -> some View {
        modifier(LimeNavigationBarModifier(
            title: title,
            showBackArrow: showBackArrow,
            backAction: backAction
        ))
        .background(backgroundColor)
    }
}
