import SwiftUI

enum TopTab: String, CaseIterable {
    case allMenu = "전체 메뉴"
    case myMenu = "나만의 메뉴"
    case cakeReservation = "홀케이크 예약"
}

enum CategoryTab: String, CaseIterable {
    case drink = "음료"
    case food = "푸드"
    case product = "상품"
}

struct OrderView: View {
    @ObservedObject var viewModel = OrderViewModel()
    @State private var selectedTopTab: TopTab = .allMenu
    @State private var selectedCategory: CategoryTab = .drink
    @Namespace private var underlineNamespace
    @State private var showSheet = false

    var body: some View {
        VStack(spacing: 0) {
            // 상단 타이틀
            HStack {
                Text("Order")
                    .font(.system(size: 24, weight: .bold))
                    .padding(.horizontal, 23)
                Spacer()
            }
            Spacer(minLength: 6)
            
            // 상단 탭
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    ForEach(TopTab.allCases, id: \.self) { tab in
                        Button(action: {
                            withAnimation(.easeInOut) {
                                selectedTopTab = tab
                            }
                        }) {
                            VStack(spacing: 4) {
                                HStack(spacing: 4) {
                                    if tab == .cakeReservation {
                                        Image("cake_icon")
                                            .resizable()
                                            .frame(width: 14, height: 14)
                                    }
                                    Text(tab.rawValue)
                                        .font(.system(size: 15, weight: .semibold))
                                        .foregroundColor(selectedTopTab == tab ? .black : .gray)
                                }
                                .padding(.horizontal, 8)
                                .padding(.vertical, 8)
                                
                                // 초록 언더라인
                                if selectedTopTab == tab {
                                    Capsule()
                                        .fill(Color.green)
                                        .matchedGeometryEffect(id: "underline", in: underlineNamespace)
                                        .frame(height: 2)
                                } else {
                                    Color.clear.frame(height: 2)
                                }
                            }
                        }
                        .frame(maxWidth: .infinity)
                    }
                }
                .background(
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(height: 1),
                    alignment: .bottom
                )
                .padding(.horizontal, 16)
                .padding(.top, 10)
            }
            
            // 하단 카테고리 탭
            HStack {
                Spacer().frame(width: 23)
                
                HStack {
                    ForEach(CategoryTab.allCases, id: \.self) { cat in
                        Button(action: {
                            selectedCategory = cat
                        }) {
                            HStack(spacing: 4) {
                                Text(cat.rawValue)
                                Text("New")
                                    .font(.caption2)
                                    .foregroundColor(.green)
                            }
                            .foregroundColor(selectedCategory == cat ? .black : .gray)
                            .font(.subheadline)
                        }
                        .frame(width: 58, height: 36)
                    }
                }
                .padding(.vertical, 18)
                .padding(.horizontal, 6)
                
                Spacer().frame(width: 243)
            }
            
            // 메뉴 리스트
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 26) {
                    ForEach(viewModel.menus) { item in
                        HStack {
                            Image(item.imageName)
                                .resizable()
                                .frame(width: 50, height: 50)
                                .cornerRadius(8)
                                .padding(.trailing, 10)
                            
                            VStack(alignment: .leading) {
                                Text(item.title)
                                    .font(.headline)
                                Text(item.subtitle)
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                            
                            Spacer()
                        }
                        .padding(.horizontal)
                    }
                }
                .padding(.top)
            }
            
            // 최하단 버튼
            VStack(spacing: 0) {
                Button(action: {
                    showSheet = true
                }) {
                    VStack{
                        HStack {
                            Text("주문할 매장을 선택해 주세요")
                                .foregroundColor(.white)
                                .font(.system(size: 14))
                            
                            Spacer()
                            
                            Image(systemName: "chevron.down")
                                .foregroundColor(.white)
                                .font(.system(size: 16, weight: .medium))
                        }
                        .padding(.horizontal)
                        .frame(height: 44)
                        .background(Color.black)
                        
                        Divider()
                            .frame(height: 1)
                            .foregroundStyle(Color.white)
                    }
                }
                .background(Color.black)
                .shadow(color: Color.black.opacity(0.2), radius: 4, y: -1) // 위쪽 그림자
            }
            .sheet(isPresented: $showSheet) {
                VStack {
                    Text("매장 선택 시트")
                        .font(.title)
                    Spacer()
                }
                .padding()
            }
        }
        
    }
}

#Preview {
    OrderView()
}
