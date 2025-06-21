//
//  FindStoreView.swift
//  Starbucks
//
//  Created by 박정환 on 5/28/25.
//

import SwiftUI

enum FindStoreSegmentOption: String, CaseIterable, Identifiable {
    case first = "매장 찾기"
    case second = "길찾기"
    
    var id: String { self.rawValue }
}

struct FindStoreView: View {
    var body: some View {
        VStack {
            navigationBar
            
            findStoreSegment()
        }
        .toolbar(.hidden)
    }
    
    private var navigationBar: some View {
        HStack {
            
            CustomBackButton()
            
            Spacer()
            
            Text("매장 찾기")
                .font(.mainTextMedium16)
                
            Spacer()
            
            Button(action: {
                
            }, label: {
               
            })
        }.padding(.horizontal, 22)
    }
}

struct findStoreSegment: View {
    @State private var segment: FindStoreSegmentOption = .first
    
    var body: some View {
            VStack(spacing: 0) {
                content

                selectedTab
            }
        }
    
    private var content: some View {
        HStack(spacing: 0) {
            ForEach(FindStoreSegmentOption.allCases) { tab in
                Button(action: {
                    segment = tab
                }) {
                    VStack {
                        Text(tab.rawValue)
                            .font(.mainTextBold24)
                            .foregroundStyle(.black)
                        
                        Rectangle()
                            .frame(width: 120, height: 3)
                            .clipShape(.capsule)
                            .foregroundColor(segment == tab ? .brown02 : .white)
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
                MapView(viewModel: JSONParsingViewModel(), hasDraggedMap: .constant(false))
                    .ignoresSafeArea()
            case .second:
                Text("길찾기 뷰")
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    FindStoreView()
}
