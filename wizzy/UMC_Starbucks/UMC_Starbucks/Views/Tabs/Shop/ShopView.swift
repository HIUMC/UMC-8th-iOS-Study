//
//  ShopView.swift
//  UMC_Starbucks
//
//  Created by 이서현 on 4/2/25.
//

import SwiftUI

struct ShopView: View {
    @StateObject var shopAllprodViewModel: ShopAllprodViewModel = ShopAllprodViewModel()
    @State private var headerOffsets: (CGFloat, CGFloat) = (0, 0)

    var body: some View {
        ScrollView(.vertical) {
            VStack(spacing: 0) {
                headerView()

                LazyVStack(alignment: .leading, spacing: 30, pinnedViews: [.sectionHeaders]) {
                    Section(content: {
                        shopTopBanner()
                        allProductsView()
                        BestItemsView()
                        NewProductsView()
                    }, header: {
                        pinnedHeaderView()
                            .modifier(OffsetModifier(offset: $headerOffsets.0, returnromStart: false))
                            .modifier(OffsetModifier(offset: $headerOffsets.1))
                    })
                }
                .safeAreaPadding(.horizontal, 16)
                .contentMargins(.top, 20)
                .padding(.bottom, 100)
            }
        }
        .ignoresSafeArea()
        .coordinateSpace(name: "SCROLL")
        .background(Color.bg)
    }
    
    private func shopTopBanner() -> some View {
            ScrollView(.horizontal) {
                VStack (alignment: .leading) {
                    LazyHStack(spacing: 28, content:  {
                        Image("shopTopBanner1")
                        Image("shopTopBanner2")
                        Image("shopTopBanner3")
                    })
                    .padding(.top, 16)
                }
            }
            .frame(height: 230)
            .padding(.horizontal, 16)
            
        } // shopTopBanner


    @ViewBuilder
    private func headerView() -> some View {
        GeometryReader { proxy in
            let minY = proxy.frame(in: .named("SCROLL")).minY
            let size = proxy.size
            let height = max(0, size.height + minY)

            Rectangle()
                .fill(Color.bg)
                .frame(width: size.width, height: height, alignment: .top)
                .offset(y: -minY)
        }
        .frame(height: 20)
    }

    @ViewBuilder
    private func pinnedHeaderView() -> some View {
        let threshhold = -(getScreenSize().height * 0.05)

        HStack {
            if headerOffsets.0 < threshhold {
                Spacer()
            }

            Text("Starbucks Online Store")
                .font(.PretendardSemiBold22)

            Spacer()
        }
        .frame(height: 90, alignment: .bottomLeading)
        .safeAreaPadding(.bottom, headerOffsets.0 < threshhold ? 20 : 0)
        .background(Color.bg)
    }

    private func allProductsView() -> some View {
        VStack(alignment: .leading) {
            Text("All Products")
                .font(.PretendardSemiBold24)
                .foregroundStyle(Color.black03)
                .kerning(-0.5)

            ScrollView(.horizontal) {
                LazyHStack(spacing: 17) {
                    ForEach(shopAllprodViewModel.shopAllprodList) { prod in
                        CircleShopImageCard(
                            imageName: prod.imageName, prodTitle: prod.prodName)
                    }
                }
            }
            .frame(height: 130)
        }
        .padding(.top, 30)
    }
}

func getScreenSize() -> CGSize {
    return UIScreen.main.bounds.size
}

struct OffsetModifier: ViewModifier {
    @Binding var offset: CGFloat
    var returnromStart: Bool = true

    func body(content: Content) -> some View {
        content
            .background(
                GeometryReader { proxy in
                    let minY = proxy.frame(in: .named("SCROLL")).minY

                    Color.clear
                        .preference(key: OffsetKey.self, value: minY)
                        .onPreferenceChange(OffsetKey.self) { value in
                            if returnromStart {
                                offset = value
                            } else {
                                offset = value
                            }
                        }
                }
            )
    }
}

struct OffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

#Preview {
    ShopView()
}
