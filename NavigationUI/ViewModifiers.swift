//
//  ViewModifiers.swift
//  NavigationUI
//
//  Created by Seth Faxon on 10/22/22.
//

import SwiftUI

struct InsertModifier: ViewModifier & Animatable {
    init(active: Bool, navigation: NavigationModel) {
        self.active = active
        progress = active ? 1 : 0
        self.navigation = navigation
    }

    var active: Bool
    var progress: CGFloat
    var navigation: NavigationModel

    var animatableData: CGFloat {
        get { progress }
        set { progress = newValue }
    }

    func body(content: Content) -> some View {
        GeometryReader { proxy in
            makeView(content: content, proxy: proxy)
        }
    }

    func makeView(content: Content, proxy: GeometryProxy) -> some View {
        let width = proxy.frame(in: .local).width
        var progressPrime = progress
        if !active {
            progressPrime = 1 - progress
        }
        if navigation.isBack {
            return content.offset(x: -width * progress, y: 0)
        } else {
            if active {
                return content.offset(x: width * progressPrime, y: 0)
            } else {
                // new view coming in
                print("InsertModifier offset: \(width), progress: \(progress)")
                return content.offset(x: width * progress, y: 0)
            }
        }
    }
}

struct RemoveModifier: ViewModifier & Animatable {
    init(offset: CGFloat, active: Bool, navigation: NavigationModel) {
        self.offset = offset
        self.active = active
        progress = active ? 1 : 0
        self.navigation = navigation
    }

    var active: Bool
    var offset: CGFloat = .zero
    var progress: CGFloat
    var navigation: NavigationModel

    var animatableData: CGFloat {
        get { progress }
        set { progress = newValue }
    }

    func body(content: Content) -> some View {
        if navigation.isBack {
            if active {
                return content.offset(x: offset * progress, y: 0)
            } else {
                return content.offset(x: -offset * progress, y: 0)
            }
        } else {
            if active {
                return content.offset(x: -offset * progress, y: 0)
            } else {
                // new view coming in
                print("RemoveModifier offset: \(offset), progress: \(progress)")
                return content.offset(x: offset * progress, y: 0)
            }
        }
    }
}
