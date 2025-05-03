//
//  OrderView.swift
//  Starbucks
//
//  Created by nau on 4/30/25.
//

import SwiftUI

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
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Order")
                .font(.mainTextBold24)
                .padding(.horizontal, 23)
            
            topSegment()
        }
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
                            .foregroundColor(segment == tab ? .black01 : .gray04)
                            .font(.mainTextBold18)
                        Rectangle()
                            .frame(height: 3)
                            .foregroundColor(segment == tab ? .green01 : .gray01)
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
    var body: some View {
        VStack {
            bottomSegment()
        }
    }
}

struct bottomSegment: View {
    @State private var segment: SegmentOption2 = .drink
    
    var body: some View {
        VStack(alignment: .leading) {
                content
                .frame(maxWidth: UIScreen.screenSize.width/2.5)
                .padding(.horizontal, 10)

                selectedTab
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
                            .foregroundColor(segment == tab ? .black01 : .gray04)
                            .font(.mainTextSemibold16)
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
            case .drink:
                OrderDrinkView()
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
}
