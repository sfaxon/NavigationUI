//
//  NavigationModel.swift
//  NavigationUI
//
//  Created by Seth Faxon on 10/20/22.
//

import Combine
import SwiftUI

class NavigationModel: ObservableObject {
    enum NavigationItem {
        case landing
        case showCamera
        case showMonitorList
        case showMonitor
    }

    @Published var current: NavigationItem = .landing
    func close() {
        switch current {
        case .showMonitor:
            current = .showMonitorList
        default:
            current = .landing
        }
    }

    func makeMeACamera() {
        current = .showCamera
    }

    func showMonitorList() {
        current = .showMonitorList
    }

    func showMonitor() {
        current = .showMonitor
    }
}
