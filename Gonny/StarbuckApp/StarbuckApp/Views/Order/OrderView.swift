//
//  OrderView.swift
//  StarbuckApp
//
//  Created by 박병선 on 3/31/25.
//
import SwiftUI

struct OrderView: View {
    @StateObject private var viewModel = OrderViewModel()
    @Namespace private var segmentNamespace

    var body: some View {
        VStack(spacing: 0) {
            topSegmentView
            Divider()

            if viewModel.selectedTopSegment == .allMenu {
                bottomSegmentView
                Divider()

                Group {
                    if viewModel.selectedBottomSegment == .drink {
                        coffeeListView
                    } else {
                        placeholderView
                    }
                }
                .frame(maxHeight: .infinity)
            } else {
                placeholderView
                    .frame(maxHeight: .infinity)
            }

            storeSelectBar
        }
        .sheet(isPresented: $viewModel.showStoreSheet) {
            OrderSheetView()
                .presentationDetents([.medium, .large])
        }
    }
}

extension OrderView {
    private var topSegmentView: some View {
        VStack(spacing: 18) {
            Text("Order")
                .font(.mainTextBold26)
                .foregroundColor(Color("black03"))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 20)

            GeometryReader { geo in
                ZStack(alignment: .bottomLeading) {
                    Rectangle()
                        .fill(Color("gray02"))
                        .frame(height: 1)
                        .padding(.horizontal, 20)

                    Capsule()
                        .fill(Color("green01"))
                        .frame(width: geo.size.width / CGFloat(TopSegment.allCases.count), height: 3)
                        .offset(x: underlineOffset(in: geo.size.width), y: 18)
                        .animation(.easeInOut(duration: 0.3), value: viewModel.selectedTopSegment)

                    HStack(spacing: 0) {
                        ForEach(TopSegment.allCases, id: \.self) { segment in
                            Button(action: {
                                if segment != .cakeReservation {
                                    withAnimation(.easeInOut(duration: 0.3)) {
                                        viewModel.selectedTopSegment = segment
                                    }
                                }
                            }) {
                                HStack(spacing: 4) {
                                    if segment == .cakeReservation {
                                        Image("cakeicon")
                                            .resizable()
                                            .frame(width: 24, height: 24)
                                    }
                                    Text(segment.rawValue)
                                }
                                .font(.mainTextBold16)
                                .foregroundColor(segment == .cakeReservation
                                                 ? Color("green01")
                                                 : (viewModel.selectedTopSegment == segment
                                                    ? Color("black01")
                                                    : Color("gray04")))
                                .frame(maxWidth: .infinity)
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                }
            }
            .frame(height: 50)
        }
    }

    private func underlineOffset(in totalWidth: CGFloat) -> CGFloat {
        guard let index = TopSegment.allCases.firstIndex(of: viewModel.selectedTopSegment) else { return 0 }
        let count = CGFloat(TopSegment.allCases.count)
        return totalWidth / count * CGFloat(index)
    }

    private var bottomSegmentView: some View {
        HStack(spacing: 10) {
            ForEach(BottomSegment.allCases, id: \.self) { segment in
                Button(action: {
                    withAnimation {
                        viewModel.selectedBottomSegment = segment
                    }
                }) {
                    HStack(spacing: 2) {
                        Text(segment.rawValue)
                            .font(.mainTextSemiBold16)
                            .foregroundColor(
                                viewModel.selectedBottomSegment == segment
                                ? Color("black01")
                                : Color("gray04")
                            )

                        Image("new")
                            .resizable()
                            .frame(width: 16, height: 6.5)
                    }
                    .padding(.vertical, 8)
                }
            }
        }
        .background(.white)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.leading, 30)
    }

    private var coffeeListView: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 16) {
                ForEach(viewModel.orderCoffeeItems) { item in
                    OrdercoffeeItemView(coffee: item)
                }
            }
            .font(.mainTextSemiBold16)
            .foregroundColor(Color("gray06"))
            .padding(.horizontal)
            .padding(.top, 8)
        }
    }

    private var placeholderView: some View {
        VStack {
            Spacer()
            Text("준비 중입니다")
                .foregroundColor(Color("gray06"))
                .font(.mainTextSemiBold16)
            Spacer()
        }
    }

    private var storeSelectBar: some View {
        Button(action: {
            viewModel.showStoreSheet.toggle()
        }) {
            HStack {
                Text("주문할 매장을 선택해 주세요")
                    .font(.mainTextSemiBold16)
                    .foregroundColor(.white)
                Spacer()
                Image(systemName: "chevron.down")
                    .foregroundColor(.white)
            }
            .padding()
            .background(.black)
            .frame(height: 60)//아래의 탭뷰까지 내려가지 않도록 설정!
        }
    }
}

struct OrderView_Previews: PreviewProvider {
    @Namespace static var namespace

    static var previews: some View {
        OrderView()
            .environmentObject(OrderViewModel())
    }
}
