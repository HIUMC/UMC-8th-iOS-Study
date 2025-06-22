import SwiftUI

struct ShopView: View {

    @State var headerOffsets: (CGFloat, CGFloat) = (0, 0)

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    let viewModel: ShopViewModel = .init()

    var body: some View {
        ScrollView(.vertical) {
            VStack(spacing: 0) {
                headerView

                LazyVStack(alignment: .leading, spacing: 44, pinnedViews: [.sectionHeaders]) {
                    Section {
                        bannerImagesView
                        allProductsView
                        bestItemsView
                        newProductsView
                    } header: {
                        pinnedHeaderView
                            .modifier(OffsetModifier(offset: $headerOffsets.0, returnromStart: false))
                            .modifier(OffsetModifier(offset: $headerOffsets.1))
                    }
                }
                .safeAreaPadding(.horizontal, 16)
                .contentMargins(.top, 20)
                .padding(.bottom, 100)
            }
        }
        .ignoresSafeArea()
        .coordinateSpace(name: "SCROLL")
        .background(Color.white)
    }

    private var headerView: some View {
        GeometryReader { proxy in
            let minY = proxy.frame(in: .named("SCROLL")).minY
            let size = proxy.size
            let height = max(0, size.height + minY)

            Rectangle()
                .fill(Color.white)
                .frame(width: size.width, height: height, alignment: .top)
                .offset(y: -minY)
        }
        .frame(height: 20)
    }

    private var pinnedHeaderView: some View {
        let threshold = -(getScreenSize().height * 0.05)

        return HStack {
            if headerOffsets.0 < threshold {
                Spacer()
            }

            Text("Starbucks Online Store")
                .font(headerOffsets.0 < threshold ? .PretendardBold24 : .PretendardBold24)
                .animation(.easeInOut(duration: 0.4), value: headerOffsets.0)

            Spacer()
        }
        .frame(height: 90, alignment: .bottomLeading)
        .safeAreaPadding(.bottom, headerOffsets.0 < threshold ? 20 : 0)
        .background(Color.white)
    }

    private var bannerImagesView: some View {
        ScrollView(.horizontal) {
            LazyHStack(spacing: 16) {
                Image(.banner1).resizable().frame(width: 270, height: 216)
                Image(.banner2).resizable().frame(width: 270, height: 216)
                Image(.banner3).resizable().frame(width: 270, height: 216)
            }
        }
        .scrollIndicators(.hidden)
    }

    private var allProductsView: some View {
        VStack(alignment: .leading, spacing: 19) {
            Text("All Products")
                .font(.PretendardSemiBold22)
                .foregroundStyle(.black03)

            ScrollView(.horizontal) {
                LazyHStack {
                    Image(.product1).resizable().frame(width: 80, height: 108)
                    Image(.product2).resizable().frame(width: 80, height: 108)
                    Image(.product3).resizable().frame(width: 80, height: 108)
                    Image(.product4).resizable().frame(width: 80, height: 108)
                    Image(.product5).resizable().frame(width: 80, height: 108)
                    Image(.product6).resizable().frame(width: 80, height: 108)
                }
            }
            .scrollIndicators(.hidden)
        }
    }

    private var bestItemsView: some View {
        VStack {
            Text("Best Items")
                .font(.PretendardSemiBold22)
                .foregroundStyle(.black03)

            TabView {
                ForEach(0..<viewModel.images.count / 4, id: \.self) { pageIndex in
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(0..<4, id: \.self) { index in
                            let imageName = viewModel.images[pageIndex * 4 + index]
                            Image(imageName)
                                .resizable()
                                .frame(width: 157, height: 208)
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .always))
            .frame(height: 541)
        }
    }

    private var newProductsView: some View {
        VStack(alignment: .leading, spacing: 19) {
            Text("New Products")
                .font(.PretendardSemiBold22)
                .foregroundStyle(.black03)

            LazyVGrid(columns: columns, spacing: 19) {
                ForEach(viewModel.newproduct, id: \.self) { imageName in
                    Image(imageName)
                        .resizable()
                        .frame(width: 157, height: 208)
                }
            }
            .padding(.horizontal, 19)
        }
    }

    struct ScrollOffsetKey: PreferenceKey {
        static var defaultValue: CGFloat = 0
        static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
            value = nextValue()
        }
    }
}

extension View {
    func getScreenSize() -> CGSize {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .zero
        }
        return windowScene.screen.bounds.size
    }
}

struct OffsetModifier: ViewModifier {
    @Binding var offset: CGFloat
    var returnromStart: Bool = true
    @State var startValue: CGFloat = 0

    func body(content: Content) -> some View {
        content
            .overlay {
                GeometryReader { proxy in
                    Color.clear
                        .preference(key: OffsetKey.self, value: proxy.frame(in: .named("SCROLL")).minY)
                        .onPreferenceChange(OffsetKey.self) { value in
                            if startValue == 0 {
                                startValue = value
                            }
                            offset = (value - (returnromStart ? startValue : 0))
                        }
                }
            }
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
