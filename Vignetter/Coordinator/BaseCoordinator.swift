//
//  BaseCoordinator.swift
//  Vignetter
//
//  Created by Ferenc Knebl on 2026. 02. 27..
//

import Combine
import SwiftUI

@MainActor
class BaseCoordinator<Destination>: ObservableObject where Destination: Hashable {

    @Published var path: NavigationPath = NavigationPath()
    var startID: UUID = UUID()
    
    func push(destination: Destination) {
        path.append(destination)
    }
    
    func goBack() {
        if !path.isEmpty {
            path.removeLast()
        }
    }
    
    func reset() {
        path = NavigationPath()
        startID = UUID()
    }
}
