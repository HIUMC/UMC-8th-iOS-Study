//
//  ShopView.swift
//  StarbuckApp
//
//  Created by 박병선 on 3/31/25.
//
import SwiftUI

struct ShopView: View {
    @StateObject private var viewModel = ShopViewModel()

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(alignment: .leading, spacing: 32, pinnedViews: [.sectionHeaders]) {
                Section(header:
                    ZStack {
                        Color.white
                        HStack {
                            Text("Starbucks Online Store")
                                .font(.mainTextBold24)
                                .foregroundColor(Color("black03"))
                                .padding(.top, 27)
                            Spacer()
                        }
                        .padding(.horizontal)
                    }
                    .frame(height: 60)
                    .background(Color.white)
                    .shadow(color: Color.black.opacity(0.03), radius: 2, y: 1)
                    .zIndex(10)
                ) {
                    TopBannerView()
                    AllProductsView(items: viewModel.allItems)
                    BestItemsView(items: viewModel.bestItems)
                    NewProductsView(items: viewModel.newProducts)
                }
            }
            .padding(.horizontal)
        }
        .navigationBarHidden(true)
    }
}



struct TopBannerView: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                Image("Shop_Banner1")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 270, height: 216)
                Image("Shop_Banner2")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 270, height: 216)
                Image("Shop_Banner3")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 270, height: 216)
            }
        }
    }
}

struct AllProductsView: View {
    let items: [ProductItem]

    var body: some View {
        VStack(alignment: .leading) {
            Text("All Products")
                .font(.mainTextSemiBold22)
                .foregroundColor(Color("black03"))

            ScrollView(.horizontal, showsIndicators: true) {
                LazyHStack(spacing: 20) {
                    ForEach(items) { item in
                        VStack {
                            ZStack{
                                Circle()
                                    .fill(Color.gray.opacity(0.1))
                                    .frame(width: 80, height: 80)

                                Image(item.imageName)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 60, height: 60)
                            }
                            Text(item.name)
                                .font(.mainTextSemiBold13)
                                .foregroundColor(Color("black02"))
                        }
                    }
                }
            }
        }
    }
}

struct BestItemsView: View {
    let items: [ProductItem]
    @State private var page = 0

    var body: some View {
        VStack(alignment: .leading) {
            Text("Best Items")
                .font(.mainTextBold22)
                .foregroundColor(Color("black03"))

            TabView(selection: $page) {
                ForEach(paginate(items, pageSize: 4).indices, id: \.self) { pageIndex in
                    let pageItems = paginate(items, pageSize: 4)[pageIndex]

                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                        ForEach(pageItems) { item in
                            VStack {
                                Image(item.imageName)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 160, height: 140)
                                Text(item.name)
                                    .font(.mainTextSemiBold13)
                                    .foregroundColor(Color("black02"))
                            }
                        }
                    }
                    .padding(.horizontal)
                    .tag(pageIndex)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
            .frame(height: 360)
        }
    }

    func paginate<T>(_ array: [T], pageSize: Int) -> [[T]] {
        stride(from: 0, to: array.count, by: pageSize).map {
            Array(array[$0..<min($0 + pageSize, array.count)])
        }
    }
}

struct NewProductsView: View{
    let items: [ProductItem]

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        VStack(alignment: .leading) {
            Text("New Products")
                .font(.mainTextSemiBold22)
                .foregroundColor(Color("black03"))

            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(items) { item in
                    VStack {
                        Image(item.imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(width:127, height: 126)
                        Text(item.name)
                            .font(.mainTextSemiBold13)
                            .foregroundColor(Color("black02"))
                    }
                }
            }
        }
    }
}


#Preview {
    ShopView()
}

