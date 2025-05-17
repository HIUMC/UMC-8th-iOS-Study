//
//  OrderView.swift
//  Starbucks_App_
//
//  Created by 김지우 on 3/27/25.
//

import SwiftUI
import CoreLocation

struct OrderView: View {
    @Environment(MapListViewModel.self) var viewModel
    @State private var showPopup: Bool = false
    @State private var path: [String] = []
    @Bindable private var locationManager = LocationManager.shared

    var body: some View {
        NavigationStack(path: $path) {
            VStack(alignment: .leading) {
                Text("Order")
                    .font(.PretendardSemiBold24)
                    .padding(.horizontal, 23)

                /*TopSegment(path: $path)*/

                Spacer()

                bottomBar
            }
            .navigationDestination(for: String.self) { destination in
                switch destination {
                case "OrderDrink":
                    OrderDrinkView()
                default:
                    Text("Unknown Destination")
                }
            }
            .sheet(isPresented: $showPopup) {
                OrderSheetView()
            }
        }
    }

    private var bottomBar: some View {
        ZStack {
            Color(.black)
            VStack {
                HStack {
                    Button(action: {
                        if let location = locationManager.currentLocation {
                            viewModel.setUserLocation(location)
                            viewModel.loadGeoJSON { result in
                                switch result {
                                case .success:
                                    self.showPopup.toggle()
                                case .failure(let error):
                                    print("error: \(error)")
                                }
                            }
                        }
                    }) {
                        HStack {
                            Group {
                                Text("주문할 매장을 선택해 주세요")
                                    .font(.PretendardSemiBold16)
                                Spacer()
                                Image(systemName: "chevron.down")
                            }
                            .foregroundStyle(Color.white)
                        }
                    }
                }
                Divider().background(Color.gray)
            }
            .padding(.horizontal, 20)
        }
        .frame(maxWidth: .infinity, maxHeight: 60)
    }
}

/*struct TopSegment: View {
    @State private var segment: menuSegmentOption = .first
    @Binding var path: [String]

    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                ForEach(menuSegmentOption.allCases) { tab in
                    Button {
                        segment = tab
                    } label: {
                        VStack {
                            Text(tab.rawValue)
                                .foregroundColor(segment == tab ? .black : .gray)
                                .font(.PretendardRegular18)
                            Rectangle()
                                .frame(height: 3)
                                .foregroundColor(segment == tab ? .green01 : .gray01)
                                .shadow(color: .black.opacity(0.2), radius: 2, y: 3)
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            .padding(.vertical, 8)
            .background(Color.white)

            VStack {
                switch segment {
                case .first:
                    AllView(path: $path)
                case .second:
                    Text("나만의 메뉴 화면")
                case .third:
                    Text("홀케이크 예약 화면")
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}*/

struct AllView: View {
    @State private var segment: categorySegmentOption = .drink
    @Binding var path: [String]

    var body: some View {
        VStack(alignment: .leading) {
            segmentSelector
                .frame(maxWidth: UIScreen.main.bounds.width / 2.5)
                .padding(.horizontal, 10)
                .offset(y: 5)

            Divider()

            contentView
                .offset(y: 8)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }

    private var segmentSelector: some View {
        HStack {
            ForEach(categorySegmentOption.allCases) { tab in
                Button(action: { segment = tab }) {
                    Text(tab.rawValue)
                        .foregroundColor(segment == tab ? .black : .gray)
                        .font(.PretendardSemiBold16)
                        .frame(maxWidth: .infinity)
                }
            }
        }
        .padding(.vertical, 8)
        .background(Color.white)
    }

    @ViewBuilder
    private var contentView: some View {
        switch segment {
        case .drink:
            NavigationLink("음료 보기", value: "OrderDrink")
                .padding()
        case .food:
            Text("푸드 화면")
                .padding()
        case .product:
            Text("상품 화면")
                .padding()
        }
    }
}

enum menuSegmentOption: String, CaseIterable, Identifiable {
    case first = "전체 메뉴"
    case second = "나만의 메뉴"
    case third = "홀케이크 예약"

    var id: String { self.rawValue }
}

enum categorySegmentOption: String, CaseIterable, Identifiable {
    case drink = "음료"
    case food = "푸드"
    case product = "상품"

    var id: String { self.rawValue }
}



#Preview {
    OrderView()
        .environment(MapListViewModel())
}
