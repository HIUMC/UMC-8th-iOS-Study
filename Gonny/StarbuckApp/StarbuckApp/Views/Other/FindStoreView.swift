//
//  FindStoreView.swift
//  StarbuckApp
//
//  Created by 박병선 on 5/22/25.
//
//OtherView에서 매장위치 클릭했을 때 보일 매장찾기 및 길찾기 화면

import SwiftUI

struct FindStoreView: View {
    @State private var selectedTab: String = "길찾기"
    @StateObject private var viewModel = MapViewModel()
        private let locationManager = LocationManager.shared
    
    var body: some View {
        VStack(spacing: 20) {
            // MARK: - 상단 탭
            HStack(spacing: 0) {
                Button("매장 찾기") {
                    selectedTab = "매장 찾기"
                }
                .frame(maxWidth: .infinity)
                .padding(.bottom, 8)
                .overlay(Rectangle().frame(height: selectedTab == "매장 찾기" ? 2 : 0).foregroundColor(Color("brown01")), alignment: .bottom)
                
                Button("길찾기") {
                    selectedTab = "길찾기"
                }
                .frame(maxWidth: .infinity)
                .padding(.bottom, 8)
                .overlay(Rectangle().frame(height: selectedTab == "길찾기" ? 2 : 0).foregroundColor(Color("brown01")), alignment: .bottom)
            }
            .font(.mainTextSemiBold24)
            .foregroundColor(Color("black01"))
        }
        
        if selectedTab == "매장 찾기"{
            StoreMapView(viewModel: viewModel, locationManager: locationManager)
        }
        else {
            FindPathView()
        }
    }
}

