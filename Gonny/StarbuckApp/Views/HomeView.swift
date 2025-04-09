//
//  HomeView.swift
//  StarbuckApp
//
//  Created by 박병선 on 3/31/25.
//
import SwiftUI

struct HomeView: View {
    @State private var showAdPopup = false

    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView {
                    VStack(spacing:20) {
                        BannerView()
                        Image("bear_advertisement")
                            .resizable()
                            .scaledToFit()
                            .frame(width:420, height: 183)
                            .padding(.top, 20)
                            .ignoresSafeArea(edges: .top)
                        Spacer().frame(height: 33)

                        RecommendMenuView()

                        Image("event")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 420, height: 450)
                            .padding(.top, 20)

                        Image("serviceSubscribe")
                            .resizable()
                            .scaledToFit()
                            .frame(width:402, height:199 )
                            .padding(.top, 20)

                        WhatsNewView()

                        AdvertisementView()

                        DessertView()

                        VStack(spacing:20){
                            Image("cold_brewAd")
                                .resizable()
                                .scaledToFit()
                                .frame(width:420, height: 183)
                            Image("making_bavarageAd")
                                .resizable()
                                .scaledToFit()
                                .frame(width:420, height: 360)
                            Image("barista_favoriteAd")
                                .resizable()
                                .scaledToFit()
                                .frame(width:420, height: 182)
                        }
                    }
                }

                // 광고 팝업
                if showAdPopup {
                    AdPopupView {
                        withAnimation {
                            showAdPopup = false
                        }
                    }
                    .transition(.move(edge: .top).combined(with: .opacity))
                    .zIndex(1)
                }
            }
            .onAppear {
                withAnimation(.easeOut(duration: 0.4)) {
                    showAdPopup = true
                }

                // 자동 닫기 (3초 후)
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    withAnimation {
                        showAdPopup = false
                    }
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
