//
//  NavigationRouterView.swift
//  UMC-iOS-WorkBook-3
//
//  Created by 곽은채 on 3/31/25.
//

import SwiftUI

enum Route: Hashable {
    case home
    case detail(title: String)
    case profile(userID: Int)
}

struct NavigationRouterView: View {
    @State private var router = NavigationRouter() // 라우터 인스턴스 생성
    
    var body: some View {
        NavigationStack(path: $router.path) {
            VStack {
                
                Button("Go to Home") {
                    router.push(.home)
                }
                
                Button("Go to Detail") {
                    router.push(.detail(title: "SwiftUI Navigation"))
                }
                
                Button("Go to Profile") {
                    router.push(.profile(userID: 123))
                }
                
                Button("Reset Navigation") {
                    router.reset()
                }
            }
            .navigationDestination(for: Route.self) { route in
                switch route {
                case .home:
                    HomeView()
                case .detail(let title):
                    DetailView(title: title)
                case .profile(let userID):
                    ProfileView(userID: userID)
                }
            }
            .navigationTitle("Home")
        }
    }
}

#Preview {
    NavigationRouterView()
}

struct HomeView: View {
    var body: some View {
        VStack {
            Text("my home!!!")
        }
    }
}


struct DetailView: View {
    let title: String

    var body: some View {
        VStack {
            Text("This is \(title) View")
                .font(.largeTitle)
        }
        .navigationTitle(title)
    }
}

struct ProfileView: View {
    let userID: Int

    var body: some View {
        VStack {
            Text("User ID: \(userID)")
                .font(.largeTitle)
        }
        .navigationTitle("Profile")
    }
}
