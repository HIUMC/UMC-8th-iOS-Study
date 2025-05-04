//
//  ShopView.swift

//
//  Created by 고석현 on 4/14/25.
// 수치 보는걸 좀 더 익숙해져서 이상한데서 속도 지체 되지 않도록 하기.
//노가다하드코딩 대신 지피티에게 먼저 구조도 물어보거나 대충 혼자 머릿속으로 구상해본다음에 들가자..
import SwiftUI



struct ShopView: View {
    @StateObject private var viewModel = ShopViewModel()
       
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 30) {
                
              
                Text("Starbucks Online Store")
                    .font(.title)
                    .bold()
                    .padding(.horizontal)
                
                
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(spacing: 16) {
                        ForEach(viewModel.bannerImages, id: \.self) { banner in
                            Image(banner)
                                .resizable()
                                .scaledToFit()
//                                .frame(width: 300, height: 150)
                                .clipped()
                                .cornerRadius(8)
                                .shadow(radius: 3)
                        }
                    }
                    .padding(.horizontal)
                }
                
               
                VStack(alignment: .leading, spacing: 10) {
                    Text("All Products")
                        .font(.headline)
                        .padding(.leading)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack(spacing: 20) {
                            ForEach(viewModel.allProducts) { shopModel in
                                VStack(spacing: 6) {
                                    Image(shopModel.imageName)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 80, height: 80)
                                    Text(shopModel.name)
                                        .font(.subheadline)
                                }
                                .frame(width: 100)
                            }
                        }
                        .padding(.horizontal, 20)
                    }
                }
                
            
                VStack(alignment:.leading) {
                            Text("Best Items")
                                .font(.headline)
                                .padding(.top, 30)
                                .padding(.bottom, 8)
                                .padding(.leading)
                            
                           
                    TabView(selection: $viewModel.currentBestPage) {
                        ForEach(0..<viewModel.totalBestPages, id: \.self) { pageIndex in

                            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())],
                                      alignment: .center,
                                      spacing: 20)
                            {
                                ForEach(viewModel.bestItemsForPage(pageIndex)) { item in
                                    VStack(spacing: 4) {
                                        Image(item.imageName)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 100, height: 100)
                                        Text(item.name)
                                            .font(.subheadline)
                                            .multilineTextAlignment(.center)
                                    }
                                }
                            }
                            .padding()
                            .tag(pageIndex) // 꼭 있어야 함
                        }
                    }
                    .frame(height: 350)
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always)) // 요걸로 바꿔줘야 swipe 가능
                            
                            // 점 표시..
                            HStack {
                                Spacer()
                                ForEach(0..<2) { index in
                                    Circle()
                                        .fill(index == viewModel.currentBestPage ? Color.black : Color.gray)
                                        .frame(width: 8, height: 8)
                                        .padding(.horizontal,3)
                                        .padding(.bottom, 30)
                                        
                                        
                                }
                                Spacer()

                            }
                       
                            
                        }
                    }
                
               
                VStack(alignment: .leading, spacing: 10) {
                    Text("New Products")
                        .font(.headline)
                        .padding(.leading)
                    
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())],
                              spacing: 20) {
                        ForEach(viewModel.newProducts) { shopModel in
                            VStack(spacing: 6) {
                                Image(shopModel.imageName)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 80, height: 80)
                                Text(shopModel.name)
                                    .font(.subheadline)
                            }
                            .frame(maxWidth: .infinity)
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .padding(.vertical)
        }
    }



struct ShopView_Previews: PreviewProvider {
    static var previews: some View {
        ShopView()
    }
}

