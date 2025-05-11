//
//  StoreFindView.swift
//  Starbucks
//
//  Created by 김영택 on 5/3/25.
//

import SwiftUI

enum StoreFindSegmentOption: String, CaseIterable, Identifiable {
    case first = "매장 찾기"
    case second = "길찾기"
    
    var id: String { self.rawValue }
}

struct StoreFindView: View {
    @Environment(NavigationRouter.self) var router
    
    var body: some View {
        VStack {
            navigationBar
            
            StoreFindSegment()
        }
        .toolbar(.hidden)
    }
    
    private var navigationBar: some View {
        HStack {
            
            Button(action: {
                router.pop()
            }, label: {
                Image(systemName: "chevron.left")
                    .foregroundStyle(.black)
            })
            
            Spacer()
            
            Text("매장 찾기")
                .font(.PretendarMedium16)
                
            Spacer()
            
            Button(action: {
                
            }, label: {
               
            })
        }.padding(.horizontal, 22)
    }
}

struct StoreFindSegment: View {
    @State private var segment: StoreFindSegmentOption = .first
    
    var body: some View {
            VStack(spacing: 0) {
                content

                selectedTab
            }
        }
    
    private var content: some View {
        HStack(spacing: 0) {
            ForEach(StoreFindSegmentOption.allCases) { tab in
                Button(action: {
                    segment = tab
                }) {
                    VStack {
                        Text(tab.rawValue)
                            .font(.PretendardBold24)
                            .foregroundStyle(.black)
                        
                        Rectangle()
                            .frame(width: 120, height: 3)
                            .clipShape(.capsule)
                            .foregroundColor(segment == tab ? .brown : .white)
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
                MapView()
                    .ignoresSafeArea()
            case .second:
                Text("나만의 메뉴 화면")
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    StoreFindView()
}
