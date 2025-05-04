//
//  JSONParsingView.swift
//  UMC_Starbucks
//
//  Created by 이서현 on 5/3/25.
//

import SwiftUI
import CoreLocation

struct JSONParsingView: View {
    
    //var viewModel: JSONParsingViewModel = .init()
    @StateObject var viewModel = JSONParsingViewModel()
    @State var showSheet: Bool = false
    let storeImage = Image("cakeIcon")
    
    var sortedByDistance: [Feature] {
        guard let userLocation = LocationManager.shared.currentLocation else {
            return viewModel.allStores
        }
        
        return viewModel.allStores.sorted { //Gpt..
            let loc1 = CLLocation(latitude: $0.properties.ycoordinate, longitude: $0.properties.xcoordinate)
            let loc2 = CLLocation(latitude: $1.properties.ycoordinate, longitude: $1.properties.xcoordinate)
            return loc1.distance(from: userLocation) < loc2.distance(from: userLocation)
        }
    }
    
    var body: some View {
        
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                ForEach(sortedByDistance, id: \.properties.seq) { store in
                    VStack(alignment: .leading, spacing: 4) {
                        HStack(alignment: .top, spacing: 12) {
                            storeImage
                                .resizable()
                                .frame(width: 60, height: 60)
                                .cornerRadius(8)
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text(store.properties.storeName)
                                    .font(.headline)
                                
                                Text(store.properties.address)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                    .padding(.bottom, 15)
                                
                                HStack {
                                    if store.properties.category.contains("리저브") { //이거 enum으로 어떻게 만들지
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
                    }
                    .padding(.horizontal, 23)
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



#Preview {
    JSONParsingView()
}
