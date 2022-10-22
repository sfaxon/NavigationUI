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
    @Published var isBack = false {
        didSet {
            print("isBack = \(isBack)")
        }
    }

    @Published var page = 0

    var transitionManager: AnyTransition {
        let insert = AnyTransition.modifier(active: InsertModifier(offset: 300, active: true, navigation: self),
                                            identity: InsertModifier(offset: 300, active: false, navigation: self))
        let remove = AnyTransition.modifier(active: RemoveModifier(offset: 150, active: true, navigation: self),
                                            identity: RemoveModifier(offset: 150, active: false, navigation: self))

        return AnyTransition.asymmetric(insertion: insert, removal: remove)
    }

    func close() {
        withAnimation {
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
        withAnimation {
            isBack = false
            current = .showCamera
        }
    }

    func showMonitorList() {
        withAnimation {
            isBack = false
            current = .showMonitorList
        }
    }

    func showMonitor() {
        withAnimation {
            isBack = false
            current = .showMonitor
        }
    }
}
