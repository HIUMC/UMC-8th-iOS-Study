//
//  OrderView.swift
//  STARBUCKS
//
//  Created by 신민정 on 3/27/25.
//

import SwiftUI


struct OrderView: View {
    //상담 탭 옵션 : 전체, 나만의 메뉴, 홀케이크 예약
    @StateObject private var viewModel = CoffeeMenuViewModel()
    enum TopSegment: String, CaseIterable {
        case all = "전체 메뉴"
        case myMenu = "나만의 메뉴"
        case cake = "홀케이크 예약"
    }
    //하단 탭 옵션: 음료, 푸드, 상품
    enum BottomSegment: String, CaseIterable {
        case drink = "음료"
        case food = "푸드"
        case product = "상품"
    }
    //뷰상태
    @State private var selectedTop: TopSegment = .all
    @State private var selectedBottom: BottomSegment = .drink
    @State private var showStoreSheet = false
    var selectedTopIndex: Int {
        TopSegment.allCases.firstIndex(of: selectedTop) ?? 0
    }
    var body: some View {
        VStack(spacing: 0) {
            orderHeader
            topSegment //상담 세그먼트뷰
            Divider().padding(.top, 8)
            bottomSegment // 하단 세그먼트 뷰
                .padding(.top, 16)
            menuList // 메뉴 리스트 스크롤 뷰
                .padding(.top)
            Spacer()
            storeButton // 하단 매장 선택 버튼
        }
        .background(Color.white)
        .sheet(isPresented: $showStoreSheet) {
            OrderSheetView()
        }
    }
    
    
    var orderHeader: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Order")
                .font(.mainTextBold24)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Spacer().frame(height: 16)
        }
        .padding(.horizontal)
        .padding(.top, 16)
    }

    
    
    // 상단 세그먼트 뷰
    private let topTabWidths: [CGFloat] = [119, 119, 201]
    
    var topSegment: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                ForEach(Array(TopSegment.allCases.enumerated()), id: \.offset) { idx, segment in
                    Button {
                        withAnimation(.easeInOut) {
                            selectedTop = segment
                        }
                    } label: {
                        VStack(spacing: 4) {
                            HStack(spacing: 4) {
                                // 홀케이크 예약만 아이콘 붙이기
                                if segment == .cake {
                                    Image("cake")
                                        .resizable()
                                        .frame(width: 16, height: 16)
                                }
                                Text(segment.rawValue)
                            }
                            .font(.mainTextSemibold16)
                            .foregroundStyle(
                                selectedTop == segment
                                ? Color.green01
                                : Color.black02
                            )
                            .frame(width: topTabWidths[idx], height: 44)
                        
                            Rectangle()
                                .fill(selectedTop == segment ? Color.green01 : Color.clear)
                                .frame(height: 2)
                                .clipShape(RoundedRectangle(cornerRadius: 1, style: .continuous))
                        }
                    }
                }
                Spacer()
            }
            .background(
                Color.white
                    .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
            )
        }
    }

        
        
        
        
        //하단 세그먼트 뷰
    var bottomSegment: some View {
        HStack(spacing: 16) {
            ForEach(BottomSegment.allCases, id: \.self) { segment in
                Button(action: {
                    selectedBottom = segment
                }) {
                    HStack(spacing: 4) {
                        Text(segment.rawValue)
                            .font(.mainTextSemibold16)
                            .foregroundStyle(selectedBottom == segment ? Color.black01 : Color.gray03)
                        
                        Image("new6")
//                            .resizable()
//                            .frame(width: 10, height: 20)
                    }
                }
            }
            Spacer() // 나머지 공간 밀어내기
        }
        .padding(.leading)
    }

        
        
        //메뉴 리스트 뷰
    var menuList: some View {
        ScrollView {
            VStack(spacing: 16) {
                if selectedTop == .all && selectedBottom == .drink {
                    // ✅ 기존 커피 메뉴 리스트
                    ForEach(viewModel.coffeeMenus) { coffee in
                        HStack(spacing: 16) {
                            Image(coffee.imageName)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 60, height: 60)
                                .clipShape(Circle())

                            VStack(alignment: .leading, spacing: 4) {
                                Text(coffee.koreanName)
                                    .font(.mainTextSemibold16)
                                    .foregroundStyle(Color.gray06)
                                Text(coffee.englishName)
                                    .font(.mainTextSemiBold13)
                                    .foregroundStyle(Color.gray03)
                            }

                            Spacer()
                        }
                        .padding(.horizontal)
                    }
                }

                else if selectedBottom == .food {
                    Text("푸드 메뉴")
                        .font(.mainTextSemibold16)
                        .foregroundStyle(Color.gray06)
                }

                else if selectedBottom == .product {
                    Text("상품 메뉴")
                        .font(.mainTextSemibold16)
                        .foregroundStyle(Color.gray06)
                }

                else if selectedTop == .myMenu {
                    Text("나만의 메뉴")
                        .font(.mainTextSemibold16)
                        .foregroundStyle(Color.gray06)
                }

                else if selectedTop == .cake {
                    Text("홀케이크 예약")
                        .font(.mainTextSemibold16)
                        .foregroundStyle(Color.gray06)
                }
            }
            .padding(.top)
            Divider().padding(.top, 8)
        }
    }

        
        
        // 하단매장선택.
        var storeButton: some View {
            Button(action: {
                showStoreSheet = true // 버튼 누르면 시트 띄우기
            }) {
                HStack {
                    Text("주문할 매장을 선택해주세요")
                        .font(.mainTextSemibold16)
                        .foregroundStyle(Color.white)
                    
                    Spacer()
                    
                    Image(systemName: "chevron.down")
                        .foregroundColor(.white)
                }
                .padding()
                .frame(height: 60)
                .background(Color.black02)
            }
            
        }
    }

    
    #Preview {
        OrderView()
    }
    

