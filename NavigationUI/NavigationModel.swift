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
//    var page: Int {
//        switch current {
//        case .landing:
//            return 0
//        case .showMonitorList:
//            return 1
//        case .showMonitor:
//            return 2
//        case .showCamera:
//            return 3
//        }
//    }

    func close() {
        withAnimation {
            isBack = true
            switch current {
            case .showMonitor:
                page = 1
                current = .showMonitorList
            default:
                page = 0
                current = .landing
            }
        }
    }

    func makeMeACamera() {
//        withAnimation {
//            page = 0
//            isBack = false
//            current = .showCamera
//        }

        withTransaction(Transaction(animation: .easeIn(duration: 2))
//            Transition.asymmetric(
//            insertion: .move(edge: isBack ? .leading : .trailing),
//            removal: .move(edge: isBack ? .trailing : .leading))
        ) {
            page = 0
            isBack = false
            current = .showCamera
        }
    }

    func showMonitorList() {
        withAnimation {
            page = 1
            isBack = false
            current = .showMonitorList
        }
    }

    func showMonitor() {
        withAnimation {
            page = 2
            isBack = false
            current = .showMonitor
        }
    }
}
