//
//  AppCoordinator.swift
//  Vignetter
//
//  Created by Ferenc Knebl on 2026. 03. 03..
//

import Combine
import Foundation
import SwiftUI

enum AppState: Hashable {
    case login
    case dashboard
}

class AppCoordinator: ObservableObject {
    
    @Published var appState: AppState = .login
    
    func setState(_ appState: AppState) {
        self.appState = appState
    }
}
