//
//  NavigationModel.swift
//  NavigationUI
//
//  Created by Seth Faxon on 10/20/22.
//

import Combine
import SwiftUI

class NavigationModel: ObservableObject {
    enum NavigationItem: Equatable {
        case landing
        case showCamera
        case showMonitorList
        case showMonitor
    }

    @Published var current: NavigationItem = .landing
    @Published var isBack = false

    var transitionManager: AnyTransition {
        let insert = AnyTransition.modifier(active: InsertModifier(active: true, navigation: self),
                                            identity: InsertModifier(active: false, navigation: self))
        let remove = AnyTransition.modifier(active: RemoveModifier(active: true, navigation: self),
                                            identity: RemoveModifier(active: false, navigation: self))

        return AnyTransition.asymmetric(insertion: insert, removal: remove)
    }

    func close() {
        withAnimation(.easeInOut(duration: 0.35)) {
            isBack = true
            switch current {
            case .showMonitor:
                current = .showMonitorList
            default:
                current = .landing
            }
        }
    }

    func makeMeACamera() {
        withAnimation(.easeInOut(duration: 0.35)) {
            isBack = false
            current = .showCamera
        }
    }

    func showMonitorList() {
        withAnimation(.easeInOut(duration: 0.35)) {
            isBack = false
            current = .showMonitorList
        }
    }

    func showMonitor() {
        withAnimation(.easeInOut(duration: 0.35)) {
            isBack = false
            current = .showMonitor
        }
    }
}
