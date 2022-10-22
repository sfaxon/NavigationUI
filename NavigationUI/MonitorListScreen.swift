//
//  MonitorListScreen.swift
//  NavigationUI
//
//  Created by Seth Faxon on 10/21/22.
//

import SwiftUI

struct MonitorListScreen: View {
    @EnvironmentObject var navigation: NavigationModel
    var body: some View {
        ZStack {
            VStack {
                Button("back") {
                    navigation.close()
                }
                Text("MonitorListScreen")
                Button("detail") {
                    navigation.showMonitor()
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.yellow)
    }
}

struct MonitorListScreen_Previews: PreviewProvider {
    static var previews: some View {
        MonitorListScreen()
    }
}
