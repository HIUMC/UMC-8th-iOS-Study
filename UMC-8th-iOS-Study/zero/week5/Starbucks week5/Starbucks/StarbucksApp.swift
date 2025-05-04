//
//  StarbucksApp.swift
//  Starbucks
//
//  Created by 김영택 on 3/21/25.
//

import SwiftUI

@main
struct StarbucksApp: App {
    var body: some Scene {
        WindowGroup {
            //LoginView(viewModel: LoginViewModel(), signupViewModel: SignupViewModel())  // 프리뷰에서 ViewModel 인스턴스 전달
            //SplashView()
            //SignupView(viewModel:SignupViewModel())
            //AdView()
            BottomTabView()
            //HomeView()
            //OtherView()
            //CircleImageCardView()
            //ShopView()
            /*OrderView()
                .environment(NavigationRouter())
                .environment(MapListViewModel())
        */

        }
    }
}
