//
//  BaseCoordinator.swift
//  Vignetter
//
//  Created by Ferenc Knebl on 2026. 02. 27..
//

import Combine
import SwiftUI

protocol CoordinatorDestination: Hashable {
    associatedtype RouteView: View
    @MainActor
    var view: RouteView { get }
}

@MainActor
class BaseCoordinator<Destination: CoordinatorDestination, StartView: View>: ObservableObject {

    @Published var path: NavigationPath = NavigationPath()
    private var startID: UUID = UUID()

    private let startView: () -> StartView
    
    init(@ViewBuilder startView: @escaping () -> StartView) {
        self.startView = startView
    }
    
    var navigationView: some View {
        startView()
            .navigationDestination(for: Destination.self) { destination in
                destination.view
            }
            .id(startID)
    }
    
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
