//
//  ContentView.swift
//  NavigationUI
//
//  Created by Seth Faxon on 10/20/22.
//

import SwiftUI

extension AnyTransition {
    static var navigationSlide: AnyTransition {
        AnyTransition.asymmetric(insertion: .slide,
                                 removal: .scale)
    }

    static func isAddingToNavStack(_ bool: Bool) -> AnyTransition {
        if bool {
            return AnyTransition.asymmetric(insertion: .move(edge: .trailing),
                                            removal: .move(edge: .trailing))
        } else {
            return AnyTransition.asymmetric(insertion: .move(edge: .trailing),
                                            removal: .move(edge: .trailing))
        }
    }
}

struct ClipEffect: ViewModifier {
    var value: CGFloat

    func body(content: Content) -> some View {
        content
            .clipShape(RoundedRectangle(cornerRadius: 100 * (1 - value)).scale(value))
    }
}

// struct ContentView: View {
//    @State var state: Bool = false
//    @Namespace var ns
//    var body: some View {
//        VStack {
//            HStack {
//                if !state {
//                    Rectangle().fill(.blue)
//                        .matchedGeometryEffect(id: "1", in: ns)
//                        .frame(width: 200, height: 200)
//                }
//                Spacer()
//                if state {
//                    Circle().fill(.blue)
//                        .matchedGeometryEffect(id: "1", in: ns)
//                        .frame(width: 100, height: 100)
//                }
//            }
//            .border(Color.black)
//            .frame(width: 300, height: 200)
//            Toggle("", isOn: $state)
//        }
//        .animation(.default)
//    }
// }

// struct ContentView: View {
//    @State var page: Int = 0
//    @State private var isBack = false   // << reverse flag (not animatable)
//
//    var body: some View {
//        VStack {
//            HStack {
//                Button(action: {
//                    self.isBack = true
//                    self.page = self.page - 1
//                }) {
//                    Text("Back")
//                }
//
//                Spacer()
//
//                Button(action: {
//                    self.isBack = false
//                    self.page = self.page + 1
//                }) {
//                    Text("Next")
//                }
//            }
//            Spacer()
//
//            Group {
//                if page == 0 && isBack {
//                    landingScreen
//                        .transition(AnyTransition.asymmetric(
//                            insertion: .move(edge: .leading),
//                            removal: .move(edge: .trailing))
//                        )
//                } else if page == 0 && !isBack {
//                    landingScreen
//                        .transition(AnyTransition.asymmetric(
//                            insertion: .move(edge: .trailing),
//                            removal: .move(edge: .leading))
//                        )
//                } else if page == 1 && isBack {
//                    MonitorListScreen().transition(AnyTransition.asymmetric(
//                        insertion: .move(edge: .leading),
//                        removal: .move(edge: .trailing))
//                    )
//                } else if page == 1 && !isBack {
//                    MonitorListScreen()
//                        .transition(AnyTransition.asymmetric(
//                            insertion: .move(edge: .trailing),
//                            removal: .move(edge: .leading))
//                        )
//                } else if page == 2 {
//                    MonitorDetailScreen()
//                }
//            }
//            .animation(.default, value: self.page)   // << animate here by value
//        }
//    }
//
//    @ViewBuilder
//    var landingScreen: some View {
//        VStack {
//            Image(systemName: "globe")
//                .imageScale(.large)
//                .foregroundColor(.accentColor)
//            Text("Hello, world!")
//        }
//    }
// }

extension View {
    func myAnimation(isBack _: Bool) -> some View {
        transaction { t in
            t.animation = Animation.default.speed(3) // (speed: isBack ? 0.1 : 3)
//            t.animation = Animation.linear(duration: isBack ? 0.1 : 3)
        }
    }
}

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

struct ContentView: View {
    @StateObject var navigation = NavigationModel()
    @State var back: Bool = false
    @State var textValue: CGFloat = 10

    var body: some View {
        Group {
            Group {
                switch navigation.current {
                case .landing:
                    landingScreen

                //                    .transition(.opacity)
                case .showCamera:
                    CameraScreen()
                //                    .transition(.navigationSlide)
                case .showMonitorList:
                    MonitorListScreen()
//                        .transition(AnyTransition.asymmetric(
//                            insertion: .move(edge: navigation.isBack ? .leading : .trailing),
//                            removal: .move(edge: navigation.isBack ? .trailing : .leading))
//                        )
                //                    .transition(.navigationSlide)
                //                    .transition(.push(from: .trailing))
                case .showMonitor:
                    MonitorDetailScreen()
                    //                    .transition(.navigationSlide)
                }
            }
            .transition(t)
//            .animation(.default.speed(5), value: back)
//            .myAnimation(isBack: back)
//            .onChange(of: navigation.current) { _ in
//                update()
//            }
        }

        .environmentObject(navigation)
    }

    func update() {
        back = navigation.isBack
    }

    var t: AnyTransition {
        let insert = AnyTransition.modifier(active: InsertModifier(offset: 300, active: true, navigation: navigation),
                                            identity: InsertModifier(offset: 300, active: false, navigation: navigation))
        let remove = AnyTransition.modifier(active: RemoveModifier(offset: 150, active: true, navigation: navigation),
                                            identity: RemoveModifier(offset: 150, active: false, navigation: navigation))

        return AnyTransition.asymmetric(insertion: insert, removal: remove)
//        print("current: \(navigation.current) isBack: \(navigation.isBack)")
//        if navigation.current == .landing && !navigation.isBack {
//            print("returning: .leading")
//            return AnyTransition.move(edge: .leading)
//        }
//        if navigation.isBack {
//            print("returning: .leading")
//            return AnyTransition.move(edge: .leading)
        ////            return AnyTransition.modifier(active: ClipEffect(value: 0), identity: ClipEffect(value: 1))
//        }
//        print("returning: .trailing")
        ////        return AnyTransition.opacity
//        return AnyTransition.move(edge: .trailing)
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
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
