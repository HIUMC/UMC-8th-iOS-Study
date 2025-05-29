//
//  JSONParsingView.swift
//  UMC_Starbucks
//
//  Created by 이서현 on 5/3/25.
//

import SwiftUI
import CoreLocation
import Kingfisher

struct JSONParsingView: View {
    
    //var viewModel: JSONParsingViewModel = .init()
    @StateObject var viewModel = JSONParsingViewModel()
    @State var showSheet: Bool = false
    
    var sortedByDistance: [Feature] { //거리순으로 정렬된 매장 배열을 반환하는 계산 속성

        guard let userLocation =  LocationManager.shared.currentLocation else {
            return viewModel.allStores
            //사용자 현재 위치가 없으면 정렬하지 않고 원래 매장 리스트 그대로 반환

        }
        
        return viewModel.allStores.sorted { //Gpt..
            //매장 리스트를 사용자 위치로부터 가까운 순서로 정렬

            let loc1 = CLLocation(latitude: $0.properties.ycoordinate, longitude: $0.properties.xcoordinate)
            let loc2 = CLLocation(latitude: $1.properties.ycoordinate, longitude: $1.properties.xcoordinate)
            return loc1.distance(from: userLocation) < loc2.distance(from: userLocation)
        }
    }
    
    var body: some View {
        let stores: [Feature] = sortedByDistance
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                ForEach(stores) { store in
                    StoreRow(store: store)
                }
            }
        }
        .onAppear {
            print("✅ onAppear 호출됨") // 콘솔용
            viewModel.loadMyProfile { result in
                switch result {
                case .success(let profile):
                    print("✅ 로딩 성공: \(profile.storeName)")
                case .failure(let error):
                    print("❌ 에러 발생: \(error)")
                }
            }
        }
    }
}
        
                
        /*
        VStack {
            Button(action: {
                viewModel.loadMyProfile { result in
                    switch result {
                    case .success(_):
                        self.showSheet.toggle()
                    case .failure(let error):
                        print("error: \(error)")
                    }
                }
            }, label: {
                Text("json 파일 파싱하기 버튼")
                    .font(.headline)
                    .foregroundStyle(Color.red)
            })
            .sheet(isPresented: $showSheet, content: {
                VStack {
                        if let profile = viewModel.myProfile {
                            Text("상점 이름: \(profile.storeName)")
                            Text("주소: \(profile.address)")
                            Text("카테고리: \(profile.category)")

                        }
                    }
                .presentationDragIndicator(.visible)
            })
            .presentationDetents([.medium, .large])
            
            Spacer()
        }
         */


struct StoreRow: View {
    let store: Feature

    var imageUrl: String? {
        guard let reference = store.properties.photoReference else { return nil }
        let key = Bundle.main.object(forInfoDictionaryKey: "GOOGLE_API_KEY") as? String ?? ""
        let url = "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=\(reference)&key=\(key)"
        print("🔗 이미지 URL:", url)
        return url
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack(alignment: .top, spacing: 12) {
                if let urlString = imageUrl, let url = URL(string: urlString) {
                    KFImage(url)
                        .resizable()
                        .frame(width: 60, height: 60)
                        .cornerRadius(8)
                } else {
                    Image("cakeIcon")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .cornerRadius(8)
                }

                VStack(alignment: .leading, spacing: 4) {
                    Text(store.properties.storeName)
                        .font(.headline)

                    Text(store.properties.address)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .padding(.bottom, 15)

                    HStack {
                        if store.properties.category.contains("리저브") {
                            Image("rIcon")
                                .resizable()
                                .frame(width: 20, height: 20)
                        }

                        if store.properties.category.contains("DT") {
                            Image("dIcon")
                                .resizable()
                                .frame(width: 20, height: 20)
                        }

                        Spacer()

                        if let distance = store.distanceFromUser {
                            Text(String(format: "%.1fkm", distance))
                                .font(.PretendardRegular12)
                                .foregroundStyle(Color.black03)
                        }
                    }
                }
            }
            .onAppear {
                print("🧾 StoreRow for:", store.properties.storeName)
                print("🔗 photoReference:", store.properties.photoReference ?? "nil")
                print("🔗 imageUrl:", imageUrl ?? "nil")
            }
        }
        .padding(.horizontal, 23)
    }
}


#Preview {
    JSONParsingView()
}
