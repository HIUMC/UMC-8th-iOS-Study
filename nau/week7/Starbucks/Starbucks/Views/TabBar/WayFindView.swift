//
//  WayFindView.swift
//  Starbucks
//
//  Created by nau on 5/20/25.
//

import SwiftUI
import CoreLocation

struct WayFindView: View {
    
    @State private var start: String = ""
    @State private var end: String = ""
    
    @Environment(NavigationRouter.self) var router
    @Environment(WayFindViewModel.self) var viewModel
  
    @State private var address = ""
    
    @State private var showAlert = false
    @State private var showMapListStart = false
    @State private var showMapListEnd = false
    
    @State var realStart: CLLocationCoordinate2D? = nil
    @State var realEnd: CLLocationCoordinate2D? = nil
    
    var body: some View {
        VStack {
            
            Divider()
            
            Spacer().frame(height: 28)
            
            topView
            
            mapListView
            
            
        }
        // 커스텀은 나중에 하겟음..
        .alert(isPresented: $showAlert) {
            Alert(title:
                    Text("검색 결과가 존재하지 않습니다.").font(.mainTextSemibold14).foregroundStyle(.gray04),
                  
                  dismissButton: .default(Text("확인").font(.mainTextSemibold16).foregroundStyle(.green02)))
        }
        .task {
            viewModel.loadGeoJSON { result in
                switch result {
                case .success(_):
                    print("geo데이터 불러오기 성공~~")
                case .failure(let error):
                    print("error: \(error)")
                }
            }
            viewModel.startlocation()
        }
    }
    
    private var topView: some View {
        VStack {
            HStack {
                Text("출발")
                    .font(.mainTextSemibold16)
                
                Button(action: {
                    start = viewModel.address
                }, label: {
                    Text("현재위치")
                        .font(.mainTextSemibold13)
                        .foregroundStyle(.white01)
                        .frame(width: 58, height: 30)
                        .background(Color.brown00)
                        .clipShape(RoundedRectangle(cornerRadius: 6))
                })
                
                TextField("출발지 입력", text: $start)
                    .padding(EdgeInsets(top: 7, leading: 9, bottom: 7, trailing: 9))
                    .border(.gray01, width: 1)
                    .font(.mainTextRegular13)
                
                Button(action: {
                    let searchText = start
                    
                    viewModel.searchAddress(keyword: searchText) 
                    
                    showMapListEnd = false //end가 잇엇다면 end를 false로 만들고
                    showMapListStart = true //start true로
            
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { // alert 뜨는 걸 약간 지연해서 오류 수정..
                        if viewModel.keywordResults.isEmpty {
                            print("alert: \(showAlert)")
                            showAlert.toggle()
                        }
                    }
                    
                }, label: {
                    Image(systemName: "magnifyingglass")
                        .foregroundStyle(.black)
                })
            }
            
            HStack {
                Text("도착")
                    .font(.mainTextSemibold16)
                
                TextField("매장명 또는 주소", text: $end)
                    .padding(EdgeInsets(top: 7, leading: 9, bottom: 7, trailing: 9))
                    .border(.gray01, width: 1)
                    .font(.mainTextRegular13)
                
                Button(action: {
                    let searchText = end
                    
                    viewModel.searchAddressEnd(keyword: searchText)
                    
                    showMapListStart = false
                    showMapListEnd = true
                    
                }, label: {
                    Image(systemName: "magnifyingglass")
                        .foregroundStyle(.black)
                })
            }
            
            Button(action: {
                guard let start = realStart, let end = realEnd else {
                    print("출발, 도착 값 x")
                    return
                }
                
                Task {
                    do {
                        let route = try await viewModel.getRoute(start: start, end: end)
                        print("경로 거리: \(route.distance)")
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }, label: {
                Text("경로 찾기")
                    .font(.mainTextMedium16)
            })
            .buttonStyle(mainBtnStyle())
            .frame(maxHeight: 38)
            
        }.padding(.horizontal, 31)
    }
    
    private var mapListView: some View {
        ScrollView {
            LazyVStack {
                if showMapListStart  { //start만
                    MapListCardStart
                } else if showMapListEnd { //end만
                    MapListCardEnd
                } // 둘다 true일 경우는 없도록 할것. 둘다 false라면 맵뷰리스트는 없음
            }
        }
    }
    
    private var MapListCardStart: some View {
        ForEach(viewModel.keywordResults) { place in
            Button(action: {
                start = place.place_name // 셀 선택시 출발 텍스트 필드를 셀의 place name으로 바꿈
                if let x = Double(place.x), let y = Double(place.y) {
                    realStart = CLLocationCoordinate2D(latitude: y, longitude: x)
                }
                showMapListStart = false // 맵뷰 리스트 초기화된것처럼 보이도록 .. 실제 리스트엔 값 들어있음
            }, label: {
                VStack(alignment: .leading, spacing: 8) {
                    Text(place.place_name)
                        .font(.mainTextMedium16)
                        .foregroundStyle(Color.black)
                        .padding(.horizontal, 16)
                        .padding(.top, 16)
                    Text(place.address_name)
                        .font(.mainTextMedium13)
                        .foregroundStyle(Color.gray04)
                        .padding(.horizontal, 16)
                        .padding(.bottom, 16)
                    
                    Divider()
                        .frame(maxWidth: .infinity)
                }
            })
        }
    }
    
    private var MapListCardEnd: some View {
        ForEach(viewModel.filteredStores) { place in
            Button(action: {
                end = place.name // 셀 선택시 출발 텍스트 필드를 셀의 place name으로 바꿈
                realEnd = place.coordinate
                viewModel.filteredStores = [] // 맵뷰 리스트 초기화 되도록..
            }, label: {
                VStack(alignment: .leading, spacing: 8) {
                    Text(place.name)
                        .font(.mainTextMedium16)
                        .foregroundStyle(Color.black)
                        .padding(.horizontal, 16)
                        .padding(.top, 16)
                    Text(place.address)
                        .font(.mainTextMedium13)
                        .foregroundStyle(Color.gray04)
                        .padding(.horizontal, 16)
                        .padding(.bottom, 16)
                    
                    Divider()
                        .frame(maxWidth: .infinity)
                }
            })
            
        }
    }
}
