//
//  View+Modifier.swift
//  Vignetter
//
//  Created by Ferenc Knebl on 2026. 02. 19..
//

import SwiftUI

enum NavigationActionButtonType {
    case logout
    
    var view: () -> some View {
        switch self {
        case .logout:
            { Image(systemName: "rectangle.portrait.and.arrow.right") }
        }
    }
}

struct NavigationTitleModifier: ViewModifier {
    
    private let color: Color
    private let title: LocalizedStringKey
    private let showBackButton: Bool
    private let backAction: (() -> Void)?
    private let actionButtonType: NavigationActionButtonType?
    private let action: (() -> Void)?
    
    init(
        title: LocalizedStringKey,
        color: Color,
        showBackButton: Bool,
        backAction: (() -> Void)?,
        actionButtonType: NavigationActionButtonType?,
        action: (() -> Void)?
    ) {
        self.color = color
        self.title = title
        self.showBackButton = showBackButton
        self.backAction = backAction
        self.actionButtonType = actionButtonType
        self.action = action
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
                
                if let actionButtonType {
                    if #available(iOS 26.0, *) {
                        actionToolbarItem(label: actionButtonType.view())
                            .sharedBackgroundVisibility(.hidden)
                    } else {
                        actionToolbarItem(label: actionButtonType.view())
                    }
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
    
    private func actionToolbarItem(label: some View) -> some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            Button {
                action?()
            } label: {
                label
            }
        }
    }
}

extension View {
    func customNavigationTitle(
        title: LocalizedStringKey,
        color: Color = .navy,
        showBackButton: Bool = false,
        backAction: (() -> Void)? = nil,
        actionButtonType: NavigationActionButtonType? = nil,
        action: (() -> Void)? = nil
    ) -> some View {
        modifier(NavigationTitleModifier(
            title: title,
            color: color,
            showBackButton: showBackButton,
            backAction: backAction,
            actionButtonType: actionButtonType,
            action: action
        ))
    }
}
