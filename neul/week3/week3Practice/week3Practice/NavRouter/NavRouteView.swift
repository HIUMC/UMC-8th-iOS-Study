//
//  NavRouteView.swift
//  week3Practice
//
//  Created by tokkislove on 3/31/25.
//

import SwiftUI

struct NavRouteView: View {
    // 라우터 인스턴스
    @State private var router = NavigationRouter()
    
    var body: some View {
        NavigationStack(path: $router.path) {
            VStack {
                Button("go to home") {
                    router.push(.home)
                }
                Button("go to detail") {
                    router.push(.detail(title: "타이틀에 넣고 싶은 글자"))
                }
                Button("go to profile") {
                    router.push(.profile(userId: 11))
                }
                Button("reset navigation") {
                    router.reset()
                }
            }
            .navigationDestination(for: Route.self) { route in
                switch route {
                case .home:
                    HomeView()
                case .detail(let title):
                    DetailView(title: title)
                case .profile(let userId):
                    ProfileView(userID: userId)
                }
            }
            .navigationTitle("Home")
        }
    }
}

fileprivate struct HomeView: View {
    var body: some View {
        VStack {
            Text("my home!!!")
        }
    }
}

fileprivate struct DetailView: View {
    let title: String

    var body: some View {
        VStack {
            Text("This is \(title) View")
                .font(.largeTitle)
        }
        .navigationTitle(title)
    }
}

fileprivate struct ProfileView: View {
    let userID: Int

    var body: some View {
        VStack {
            Text("User ID: \(userID)")
                .font(.largeTitle)
        }
        .navigationTitle("Profile")
    }
}


#Preview {
    NavRouteView()
}
