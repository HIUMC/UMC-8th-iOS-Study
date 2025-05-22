//
//  FindMapView.swift
//  UMC_Starbucks
//
//  Created by 이서현 on 5/4/25.
//

import SwiftUI
import MapKit

struct FindStoreView: View {
    @State private var selectedTab: Int = 0
    @StateObject var routeVM = RouteViewModel()

    let start = CLLocationCoordinate2D(latitude: 37.5665, longitude: 126.9780)
    let end = CLLocationCoordinate2D(latitude: 37.5700, longitude: 127.0010)

    var body: some View {
        VStack(spacing: 0) {
            TopFindBar()
            MiddleFindBar(selectedTab: $selectedTab)
                .padding(.bottom, 10)
            if selectedTab == 0 {
                VStack(spacing: 0) {
                    //RouteMapView(viewModel: routeVM)
                    MapView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .edgesIgnoringSafeArea(.all)

                    if routeVM.isLoading {
                        ProgressView("경로 불러오는 중...")
                            .padding()
                    }
                }
            } else if selectedTab == 1 {
                FindMapView(selectedTab: $selectedTab)
            } else if selectedTab == 2 {
                RouteMapView(viewModel: routeVM)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .edgesIgnoringSafeArea(.all)

            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
}


struct TopFindBar: View {
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        HStack {
            Button(action: {
                dismiss()
            }) {
                Image(systemName: "chevron.left")
                    .font(.system(size: 20, weight: .medium))
                    .foregroundStyle(.black)
            }

            Spacer()
            Text("매장 찾기")
                .font(.PretendardMedium16)
            Spacer()
        }
        .padding(.horizontal, 15)
        .padding(.top, 10)

    }
}

struct MiddleFindBar: View {
    @Binding var selectedTab: Int
    @Namespace private var underlineAnimation
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<2) { index in
                let title = index == 0 ? "매장 찾기" : "길찾기"
                Button(action: {
                    withAnimation(.easeInOut) {
                        selectedTab = index
                    }
                }) {
                    Text(title)
                        .font(.PretendardSemiBold24)
                        .foregroundStyle(.black)
                        .padding(.bottom, 10)
                        .overlay(
                            ZStack {
                                if selectedTab == index {
                                    Capsule()
                                        .fill(Color.brown)
                                        .matchedGeometryEffect(id: "underline", in: underlineAnimation)
                                        .frame(width: 110, height: 4)
                                        .offset(y: 14)
                                }
                            }
                        )
                        .frame(maxWidth: .infinity)
                }
            }
        }
        .padding(.top, 20)
        .padding(.bottom, 10)
        .background(Color.white)
    }
}



#Preview {
    FindStoreView()
}
