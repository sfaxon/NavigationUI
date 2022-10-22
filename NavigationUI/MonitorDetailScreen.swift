//
//  MonitorDetailScreen.swift
//  NavigationUI
//
//  Created by Seth Faxon on 10/21/22.
//

import SwiftUI

struct MonitorDetailScreen: View {
    @EnvironmentObject var navigation: NavigationModel
    var body: some View {
        ZStack {
            VStack {
                Button("back") {
                    navigation.close()
                }
                Text("MonitorDetailScreen")
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.red)
    }
}

struct MonitorDetailScreen_Previews: PreviewProvider {
    static var previews: some View {
        MonitorDetailScreen()
    }
}
