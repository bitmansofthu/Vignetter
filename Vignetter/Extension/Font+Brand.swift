//
//  Font+Yettel.swift
//  Vignetter
//
//  Created by Ferenc Knebl on 2026. 02. 18..
//

import SwiftUI

extension CGFloat {
    enum FontSize {
        static let ultraLarge: CGFloat = 40
        static let extraLarge: CGFloat = 20
        static let large: CGFloat = 16
        static let medium: CGFloat = 14
        static let small: CGFloat = 12
        static let extraSmall: CGFloat = 11
    }
}

extension Font {
    static func brand(size: CGFloat, weight: Font.Weight = .regular) -> Self {
        // TODO: use custom font
        .system(size: size, weight: weight)
    }
    
    static var brandHeading: Font {
        .brand(size: .FontSize.extraLarge, weight: .bold)
    }
}
