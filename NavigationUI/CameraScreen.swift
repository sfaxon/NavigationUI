//
//  CameraScreen.swift
//  NavigationUI
//
//  Created by Seth Faxon on 10/20/22.
//

import SwiftUI

struct CameraScreen: View {
    @EnvironmentObject var navigation: NavigationModel

    var body: some View {
        ZStack {
            VStack {
                Button("back") {
                    withAnimation {
                        navigation.close()
                    }
                }
                Text("CameraScreen")
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.yellow)
    }
}

struct CameraScreen_Previews: PreviewProvider {
    static var previews: some View {
        CameraScreen()
    }
}
