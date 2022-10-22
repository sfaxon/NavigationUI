//
//  ViewModifiers.swift
//  NavigationUI
//
//  Created by Seth Faxon on 10/22/22.
//

import SwiftUI

// Each of these ghave a width that's a constant.
// This is an approximation of what the native UINavigationViewController does.
// As a new screen comes in, it animates the full width of the screen, but the one
// leaving only moves back about 1/3 of the view width.

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
        let frameWidth = proxy.frame(in: .local).width
        let width = frameWidth * 0.3
        if navigation.isBack {
            if active {
                // starting position when being inserted while going back
                return content.offset(x: -width * progress, y: 0)
            } else {
                return content.offset(x: -frameWidth * progress, y: 0)
            }
        } else {
            if active {
                return content.offset(x: frameWidth * progress, y: 0)
            } else {
                // new view coming in
                return content.offset(x: frameWidth * progress, y: 0)
            }
        }
    }
}

struct RemoveModifier: ViewModifier & Animatable {
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
        let frameWidth = proxy.frame(in: .local).width
        let width = frameWidth * 0.3
        if navigation.isBack {
            if active {
                // when being dismissed, how far off screen the view goes
                return content.offset(x: frameWidth * progress, y: 0)
            } else {
                return content.offset(x: -width * progress, y: 0)
            }
        } else {
            if active {
                return content.offset(x: -width * progress, y: 0)
            } else {
                // new view coming in
                return content.offset(x: width * progress, y: 0)
            }
        }
    }
}
