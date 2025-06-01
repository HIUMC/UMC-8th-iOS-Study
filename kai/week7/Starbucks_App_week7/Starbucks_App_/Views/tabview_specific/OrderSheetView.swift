//
//  OrderSheetView.swift
//  Starbucks_App_
//
//  Created by 김지우 on 5/4/25.
//


/*
import SwiftUI

enum SegmentOption3: String, CaseIterable, Identifiable {
    case first = "가까운 매장"
    case second = "자주 가는 매장"
    
    var id: String { self.rawValue }
}

struct OrderSheetView: View {
    @State private var segment: SegmentOption3 = .first
    @Environment(MapListViewModel.self) var viewModel
    
    @State var isMap: Bool = false
    @State var text: String = ""
    
    var body: some View {
        VStack {
            Spacer().frame(height: 30)
            
            titleBar
                .frame(minWidth: UIScreen.screenSize.width - 32.5, maxWidth: UIScreen.screenSize.width - 28)
            
            searchBar
                .frame(minWidth: UIScreen.screenSize.width - 32.5, maxWidth: UIScreen.screenSize.width - 28)
            
            bottomSegment
            
        }
        .presentationDragIndicator(.visible)
        .task {
            if let location = LocationManager.shared.currentLocation {
                viewModel.setUserLocation(location)
            }
        }
    }
    
    private var titleBar: some View {
        HStack {
            Button(action: {}, label: {
                Image(.map)
                    .renderingMode(.template)
                    .foregroundStyle(.white)
            })
           
            Spacer()
            
            Text("매장 설정")
                .font(.mainTextMedium16)
                .foregroundStyle(.black03)
            
            Spacer()
            
            Button(action: {
                isMap.toggle()
            }, label: {
                Image(.mapIcon)
            })
        }
    }
    
    private var searchBar: some View {
        VStack {
            TextField("검색", text: $text)
                .font(.PretendardRegular12)
                .padding(EdgeInsets(top: 4, leading: 7, bottom: 4, trailing: 7))
        }
        .background(Color.gray)
        .clipShape(RoundedRectangle(cornerRadius: 5))
    }
    
    private var bottomSegment: some View {
        VStack(alignment: .leading, spacing: 0) {
            content
                .frame(maxWidth: UIScreen.screenSize.width/2.2)

            Divider()
            
            selectedTab
        }
    }
    
    private var content: some View {
        HStack {
            ForEach(SegmentOption3.allCases) { tab in
                Button(action: {
                    segment = tab
                }) {
                    VStack {
                        Text(tab.rawValue)
                            .foregroundColor(segment == tab ? .black01 : .gray03)
                            .font(segment == tab ? .mainTextSemibold13 : .mainTextRegular13)
                    }
                }
                .frame(maxWidth: .infinity)
            }
        }
        .padding(.vertical, 8)
        .background(Color.white)
    }

    private var selectedTab : some View {
        // 실제 탭에 따른 콘텐츠 영역
        VStack{
            switch segment {
            case .first:
                if isMap {
                    MapView()
                } else {
                    MapListView()
                }
            case .second:
                if isMap {
                    MapView()
                } else {
                    Text("Second")
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
#Preview {
    OrderSheetView()
}
*/
