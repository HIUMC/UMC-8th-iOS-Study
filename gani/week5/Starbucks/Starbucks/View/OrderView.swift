//
//  OrderView.swift
//  Starbucks
//
//  Created by 이가원 on 4/13/25.
//
import SwiftUI

enum TopSegment: String, CaseIterable {
    case 전체메뉴 = "전체 메뉴"
    case 나만의메뉴 = "나만의 메뉴"
    case 홀케이크예약 = "홀케이크 예약"
}

enum BottomSegment: String, CaseIterable {
    case 음료 = "음료"
    case 푸드 = "푸드"
    case 상품 = "상품"
}

struct CoffeeMenuItem: Identifiable {
    var id = UUID()
    var name: String
    var image: String
    var engname: String
}

struct ContentView: View {
    @State private var selectedSegment: TopSegment = .전체메뉴
    @State private var animationOffset: CGFloat = 0
    @State private var selectedBottomSegment: BottomSegment = .음료
    @State private var showSheet = false
    
    let segmentWidth: CGFloat = 120
    let coffeeItems = [
        CoffeeMenuItem(name: "추천", image: "reccof", engname: "recommend"),
        CoffeeMenuItem(name: "아이스 카페 아메리카노", image: "coffee1",engname:"ice americano"),
        CoffeeMenuItem(name: "카푸치노", image: "coffee2",engname: "cappu"),
        CoffeeMenuItem(name: "카라멜 마끼아또", image: "coffee3",engname: "caramel")
    ]
    
    var body: some View {
        VStack {
            Spacer().frame(height: 59)
            Text("Order")
                .font(.custom("Pretendard-Bold", size: 24))
            HStack {
                ForEach(TopSegment.allCases, id: \.self) { segment in
                    Button(action: {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            selectedSegment = segment
                            animationOffset = segmentWidth * CGFloat(TopSegment.allCases.firstIndex(of: segment) ?? 0)
                        }
                    }) {
                        Text(segment.rawValue)
                            .foregroundColor(selectedSegment == segment ? .green : .gray)
                            .padding()
                    }
                    .frame(width: segmentWidth)
                }
            }
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 5)
            .padding()

            // 초록색 애니메이션 막대
            Rectangle()
                .foregroundColor(.green)
                .frame(width: segmentWidth, height: 3)
                .offset(x: animationOffset)
                .animation(.easeInOut(duration: 0.3), value: animationOffset)
            
            // 하단 세그먼트
            BottomSegmentView(selectedBottomSegment: $selectedBottomSegment)

            // 커피 메뉴 아이템
            CoffeeMenuView(coffeeItems: coffeeItems)

            Spacer()

            // 주문할 매장 선택 버튼
            Button(action: {
                showSheet.toggle()
            }) {
                Text("주문할 매장을 선택해주세요")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
            .sheet(isPresented: $showSheet) {
                StoreSelectionView()
            }
        }
        .padding()
        .ignoresSafeArea()
    }
}

// 하단 세그먼트 (음료, 푸드, 상품 버튼)
struct BottomSegmentView: View {
    @Binding var selectedBottomSegment: BottomSegment
    
    var body: some View {
        HStack {
            ForEach(BottomSegment.allCases, id: \.self) { segment in
                Button(action: {
                    selectedBottomSegment = segment
                }) {
                    Text(segment.rawValue)
                        .foregroundColor(selectedBottomSegment == segment ? .green : .gray)
                        .padding()
                        .background(selectedBottomSegment == segment ? Color.green.opacity(0.2) : Color.clear)
                        .cornerRadius(10)
                }
            }
        }
        .padding()
    }
}

// 커피 메뉴 아이템을 LazyVGrid로 표시
struct CoffeeMenuView: View {
    let coffeeItems: [CoffeeMenuItem]
    
    var body: some View {
        LazyVStack(alignment: .leading, spacing: 10) {
            ForEach(coffeeItems) { item in
                HStack {
                    Image(systemName: item.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                    VStack(alignment: .leading){
                        Text(item.name)
                            .font(.custom("Pretendard-SemiBold", size: 16))
                            .foregroundColor(.gray6)
                        Text(item.engname)
                            .font(.custom("Pretendard-SemiBold", size: 13))
                            .foregroundColor(.gray02)
                        

                    }
                    
                    Spacer()
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 10).stroke(Color.white))
            }
        }
        .padding()
    }
}

// 매장 선택 화면
struct StoreSelectionView: View {
    var body: some View {
        VStack {
            Text("매장을 선택하세요.")
            // 매장 목록 등 추가 구성 가능
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
