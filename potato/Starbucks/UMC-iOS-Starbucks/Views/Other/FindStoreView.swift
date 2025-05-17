//
//  FindStoreView.swift
//  UMC-iOS-Starbucks
//
//  Created by 곽은채 on 5/2/25.
//

import SwiftUI
import CoreLocation

struct FindStoreView: View {
    @EnvironmentObject private var router: NavigationRouter
    @State private var selectedTab = 0
    
    @State var viewModel: JSONParsingViewModel
    @Bindable private var locationManager: LocationManager = .shared
    
    var body: some View {
        VStack {
            topNav
            menuTabBar
            
            if selectedTab == 0 {
                MapView(showsUserLocationButton: true)
                    .ignoresSafeArea()
            } else {
                Text("길 찾기")
                Spacer()
            }
        }
        .toolbarVisibility(.hidden)
        .onAppear {
            locationManager.requestAuthorization()
            locationManager.startUpdatingLocation()
            
            viewModel.loadStoreList { result in
                switch result {
                case .success(_):
                    print("가까운 매장 반환")
                case .failure(let error):
                    print("store list error: \(error)")
                }
            }
        }
        .onChange(of: locationManager.currentLocation) {
            if let location = locationManager.currentLocation {
                // 정확도 50미터 이하인 위치만 사용
                let desiredAccuracy: CLLocationAccuracy = 50
                if location.horizontalAccuracy <= desiredAccuracy {
                    viewModel.userLocation = location
                    print(location.coordinate.latitude, location.coordinate.longitude )
                }
            }
        }
        .onDisappear {
            locationManager.stopUpdatingLocation()
        }
    }
    
    private var topNav: some View {
        HStack {
            Button(action: {
                router.pop()
            }) {
                Image(systemName: "chevron.left")
            }
            .foregroundStyle(Color("black00"))
            
            Spacer()
            
            Text("매장 찾기")
                .font(.mainTextMedium16)
                .foregroundStyle(Color("black00"))
            
            Spacer()
        }
        .padding(.horizontal, 32)
        .padding(.vertical, 20)
        .background(Color("white00"))
    }
    
    private var menuTabBar: some View {
        HStack {
            ForEach(FindMenuItems.allCases, id:\.self) { menu in
                Button(action: {
                    selectedTab = menu.id
                }, label: {
                    VStack(spacing: 8) {
                            Text(menu.title)
                                .foregroundStyle(Color("black00"))
                                .font(.mainTextSemiBold24)
                        
                        Rectangle()
                            .fill(selectedTab == menu.id ? Color("brown02") : .clear)
                            .frame(width:120, height: 3)
                    }
                })
                
                if menu.id == 0 {
                    Spacer()
                }
            }
        }
        .padding(.horizontal, 52)
        .background(Color("white00"))
        .frame(height: 60)
    }
}

#Preview {
    FindStoreView(viewModel: JSONParsingViewModel())
}

enum FindMenuItems: Int, CaseIterable, Identifiable {
    case store
    case load
    
    var id: Int { rawValue }
    
    var title: String {
        switch self {
        case .store:
            return "매장 찾기"
        case .load:
            return "길찾기"
        }
    }
}
