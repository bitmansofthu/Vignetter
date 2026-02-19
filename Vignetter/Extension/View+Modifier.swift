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
    private let backAction: (() -> Void)?
    
    init(
        title: LocalizedStringKey,
        color: Color,
        backAction: (() -> Void)?
    ) {
        self.color = color
        self.title = title
        self.backAction = backAction
    }
    
    func body(content: Content) -> some View {
        content
            .toolbar {
                if backAction != nil {
                    if #available(iOS 26.0, *) {
                        backToolbarItem
                            .sharedBackgroundVisibility(.hidden)
                    } else {
                        backToolbarItem
                    }
                }
                
                ToolbarItem(placement: .principal) {
                    Text("dashboard_title")
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

extension View {
    func customNavigationTitle(
        title: LocalizedStringKey,
        color: Color = .navy,
        backAction: (() -> Void)? = nil
    ) -> some View {
        modifier(NavigationTitleModifier(
            title: title,
            color: color,
            backAction: backAction
        ))
    }
}
