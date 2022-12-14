//
//  ContentView.swift
//  NavigationUI
//
//  Created by Seth Faxon on 10/20/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var navigation = NavigationModel()

    var body: some View {
        Group {
            Group {
                switch navigation.current {
                case .landing:
                    landingScreen
                        .zIndex(0)
                case .showCamera:
                    CameraScreen()
                        .zIndex(1)
                case .showMonitorList:
                    MonitorListScreen()
                        .zIndex(2)
                case .showMonitor:
                    MonitorDetailScreen()
                        .zIndex(3)
                }
            }
            .transition(navigation.transitionManager)
        }
        .environmentObject(navigation)
    }

    @ViewBuilder
    var landingScreen: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
            Button("show camera") {
                navigation.makeMeACamera()
            }
            Button("show monitor list") {
                navigation.showMonitorList()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
