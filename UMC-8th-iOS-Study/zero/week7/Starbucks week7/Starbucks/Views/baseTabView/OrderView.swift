//
//  Order.swift
//  Starbucks
//
//  Created by 김영택 on 3/29/25.
//

import SwiftUI
import CoreLocation

enum SegmentOption: String, CaseIterable, Identifiable {
    case first = "전체 메뉴"
    case second = "나만의 메뉴"
    case third = "홀케이크 예약"
    
    var id: String { self.rawValue }
}

enum SegmentOption2: String, CaseIterable, Identifiable {
    case drink = "음료"
    case food = "푸드"
    case product = "상품"
    
    var id: String { self.rawValue }
}

struct OrderView: View {
    @Environment(NavigationRouter.self) var router
    @Environment(MapListViewModel.self) var viewModel
    
    @State var showPopup: Bool = false
    
    @StateObject private var locationManager = LocationManager.shared
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Order")
                .font(.PretendardBold24)
                .padding(.horizontal, 23)
            
            topSegment()
            
            Spacer()
            
            bottomBar
        }.sheet(isPresented: $showPopup) {
            OrderSheetView()
                .environment(viewModel)        }
    }
    
    
    private var bottomBar: some View {
        ZStack {
            Color(.black)
            
            VStack {
                HStack {
                    Button(action: {
                        self.showPopup.toggle()
                    }) {
                        HStack {
                            Group {
                                Text("주문할 매장을 선택해 주세요")
                                    .font(.PretendardSemibold16)
                                Spacer()
                                Image(systemName: "chevron.down")
                            }.foregroundStyle(Color.white)
                        }
                    }
                }
                
                Divider()
                    .background(Color.gray)
                
            }.padding(.horizontal, 20)
        }.frame(maxWidth: .infinity, maxHeight: 60)
    }
}

struct topSegment: View {
    @State private var segment: SegmentOption = .first
    
    var body: some View {
            VStack(spacing: 0) {
                content

                selectedTab
            }
        }
    
    private var content: some View {
        HStack(spacing: 0) {
            ForEach(SegmentOption.allCases) { tab in
                Button(action: {
                    segment = tab
                }) {
                    VStack {
                        Text(tab.rawValue)
                            .foregroundColor(segment == tab ? .black : .gray)
                            .font(.PretendardBold16)
                        Rectangle()
                            .frame(height: 3)
                            .foregroundColor(segment == tab ? .green : .gray)
                            .shadow(color: Color(white: 0, opacity: 0.2), radius: 2, y: 3)
                    }
                }
                .frame(maxWidth: .infinity)
            }
        }.padding(.vertical, 8)
        .background(Color.white)
    }

    private var selectedTab : some View {
        // 실제 탭에 따른 콘텐츠 영역
        VStack {
            switch segment {
            case .first:
                allView()
            case .second:
                Text("나만의 메뉴 화면")
            case .third:
                Text("홀케이크 예약 화면")
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct allView: View {
    @State private var segment: SegmentOption2 = .drink
    var body: some View {
        VStack {
            bottomSegment
        }
    }
    
    private var bottomSegment: some View {
        VStack(alignment: .leading) {
            content
                .frame(maxWidth: UIScreen.main.bounds.width / 2.5) // 수정된 부분
                .padding(.horizontal, 10)
                .offset(y: 5)
            
            Divider()
            
            selectedTab
                .offset(y: 8)
        }
    }

    
    private var content: some View {
        HStack {
            ForEach(SegmentOption2.allCases) { tab in
                Button(action: {
                    segment = tab
                }) {
                    VStack {
                        Text(tab.rawValue)
                            .foregroundColor(segment == tab ? .black : .gray)
                            .font(.PretendardSemibold16)
                    }
                }
                .frame(maxWidth: .infinity)
            }
        }.padding(.vertical, 8)
        .background(Color.white)
    }

    private var selectedTab : some View {
        // 실제 탭에 따른 콘텐츠 영역
        VStack{
            switch segment {
            case .drink:
                OrderCircleImage()
            case .food:
                Text("나만의 메뉴 화면")
            case .product:
                Text("홀케이크 예약 화면")
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}


#Preview {
    OrderView()
        .environment(NavigationRouter())
        .environment(MapListViewModel())
}
