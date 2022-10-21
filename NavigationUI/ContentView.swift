//
//  ContentView.swift
//  NavigationUI
//
//  Created by Seth Faxon on 10/20/22.
//

import SwiftUI

extension AnyTransition {
    static var navigationSlide: AnyTransition {
        AnyTransition.asymmetric(insertion: .move(edge: .trailing),
                                 removal: .move(edge: .trailing))
    }
}

struct ContentView: View {
    @StateObject var navigation = NavigationModel()

    var body: some View {
        Group {
            switch navigation.current {
            case .landing:
                landingScreen
                    .transition(.opacity)
            case .showCamera:
                CameraScreen()
                    .transition(.navigationSlide)
            case .showMonitorList:
                MonitorListScreen()
                    .transition(.navigationSlide)
            case .showMonitor:
                MonitorDetailScreen()
                    .transition(.navigationSlide)
            }
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
                withAnimation {
                    navigation.makeMeACamera()
                }
            }
            Button("show monitor list") {
                withAnimation {
                    navigation.showMonitorList()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
