//
//  ViewModifiers.swift
//  NavigationUI
//
//  Created by Seth Faxon on 10/22/22.
//

import SwiftUI

struct InsertModifier: ViewModifier & Animatable {
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
        _ = print("InsertModifier progress: \(progress), active: \(active) ")
        var progressPrime = progress
        if !active {
            progressPrime = 1 - progress
        }
        if navigation.isBack {
            return content.offset(x: -offset * progress, y: 0)
        } else {
            if active {
                return content.offset(x: offset * progressPrime, y: 0)
            } else {
                // new view coming in
                print("InsertModifier offset: \(offset), progress: \(progress)")
                return content.offset(x: offset * progress, y: 0)
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
        _ = print("RemoveModifier progress: \(progress), active: \(active) ")
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
