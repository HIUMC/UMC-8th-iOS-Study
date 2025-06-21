//
//  FindRouteView.swift
//  Starbucks
//
//  Created by 박정환 on 5/22/25.
//

/*
import SwiftUI
import CoreLocation

struct FindMapView : View {
    
    @Bindable var locationManager: LocationManager
    @Binding var isFindStore: Bool
    
    @State var isRouteLoading: Bool = false
    @State var showStart: Bool = false
    @State var showEnd: Bool = false
    @State private var showAlert: Bool = false
    
    @FocusState private var isFocused: Bool
    
    @EnvironmentObject var parsingViewModel: JSONParsingViewModel
    @EnvironmentObject var mapViewModel: MapViewModel
    

    
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 0) {
                topView
                if showStart {
                    startSearchResult
                } else if showEnd {
                    endSearchResult
                } else {
                    Spacer()
                }
            }
        }
    }

    
    private var topView: some View {
        VStack {
            HStack {
                Text("출발")
                    .font(.mainTextSemiBold16)
                Button(action: {
                    // 현재 위치 버튼 눌렀을 때 기본 주소 값만 대입
                    start = $locationManager.address
                }, label: {
                    Text("현재 위치")
                        .foregroundStyle(.white)
                        .font(.mainTextSemiBold13)
                        .frame(width: 58, height: 30)
                        .background(.brown01)
                        .clipShape(RoundedRectangle(cornerRadius: 6))
                })
                TextField("매장명 또는 주소", text: )
                    .focused($isFocused)
                    .textFieldStyle(.roundedBorder)
                Button(action: {
                    // 검색 로직 생략
                }) {
                    Image(systemName: "magnifyingglass")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundStyle(Color.black)
                }
            }
            HStack {
                Text("도착")
                    .font(.mainTextSemiBold16)
                TextField("매장명 또는 주소", text: )
                    .focused($isFocused)
                    .textFieldStyle(.roundedBorder)
                Button(action: {
                }) {
                    Image(systemName: "magnifyingglass")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundStyle(Color.black)
                }
            }
            Button(action: {
                // 경로 요청 로직
            }, label: {
                Text("경로 찾기")
                    .foregroundStyle(.white)
                    .font(.mainTextMedium16)
                    .frame(maxWidth: .infinity, minHeight: 38)
                    .background(.green00)
                    .cornerRadius(10)
            })
        }
    }
    
    
    private var startSearchResult: some View {
        ScrollView(.vertical) {
            LazyVStack(spacing: 16) {

            }
        }
        .scrollIndicators(.hidden)
    }
    
    private var endSearchResult: some View {
        ScrollView(.vertical) {
            LazyVStack(spacing: 16) {

            }
        }
    }
*/
