//
//  HomeView.swift
//  cloneStarbucks
//
//  Created by tokkislove on 3/31/25.
//

import SwiftUI

struct HomeView: View {
    @AppStorage("nickname") private var nickname: String = "(작성한 닉네임)"
    @EnvironmentObject var router: NavigationRouter
    @State private var viewModel = CoffeeDetailViewModel()
    private var whatNewViewModel: NewEventViewModel = .init()
    
    var body: some View {
        ScrollView(.vertical) {
            LazyVStack(spacing: 15) {
                BannerView()
                
                Image(.home2)
                    .resizable()
                    .frame(maxWidth: .infinity, maxHeight: 183)
                    .padding(.horizontal, 10)
                    .clipShape(RoundedRectangle(cornerRadius: 5))

                RecommendMenuView(viewModel: $viewModel)
                    .padding(.leading, 20)
                
                Group {
                    Image(.home4)
                        .resizable()
                        .frame(maxWidth: .infinity, maxHeight: 451)
                    
                    Image(.home5)
                        .resizable()
                        .frame(maxWidth: .infinity, maxHeight: 199)
                }
                .padding(.horizontal, 10)
                
                whatsNew
                    .padding(.leading, 10)
                
                banners
                    .padding(.horizontal, 10)
                
                dessertMenu
                    .padding(.leading, 20)
                
                events
                    .padding(.horizontal, 10)
            }
        }
        .toolbar(.hidden, for: .navigationBar)
        .ignoresSafeArea()
    }
    
    
    
    
    private var whatsNew: some View {
        VStack(spacing: 10) {
            HStack {
                Image(.home6)
                    .padding(.leading, 20)
                Spacer()
            }
            
            ScrollView(.horizontal) {
                LazyHStack(spacing: 16) {
                    ForEach(whatNewViewModel.newEvents, id: \.self) { new in
                        NewEventCard(imageName: new.imageName, title: new.title, content: new.content)
                    }
                }
            }
            .scrollIndicators(.hidden)
        }
        .padding(.top, 10)
    }
    
    
    private var banners: some View {
        VStack {
            Image(.home8)
                .resizable()
                .frame(maxWidth: .infinity)
                .aspectRatio(contentMode: .fit)
            Image(.home9)
                .resizable()
                .frame(maxWidth: .infinity)
                .aspectRatio(contentMode: .fit)
                .clipShape(RoundedRectangle(cornerRadius: 4))
            Image(.home10)
                .resizable()
                .frame(maxWidth: .infinity)
                .aspectRatio(contentMode: .fit)
                .clipShape(RoundedRectangle(cornerRadius: 2))
            
        }
    }
    
    private var dessertMenu: some View {
        VStack {
            HStack {
                Text("하루가 달콤해지는 디저트")
                    .foregroundStyle(.black03)
                    .font(.MainTextBold24)
                Spacer()
                
            }
            ScrollView(.horizontal) {
                LazyHStack(spacing: 15) {
                    ForEach(DessertModel.dummy, id: \.self) { dessert in
                        CircleImageCard(imageName: dessert.imageName, title: dessert.title)
                    }
                }
            }
            .scrollIndicators(.hidden)
        }
    }

    private var events: some View {
        VStack {
            Image(.home12)
                .resizable()
                .frame(maxWidth: .infinity)
                .aspectRatio(contentMode: .fit)
            Image(.home13)
                .resizable()
                .frame(maxWidth: .infinity)
                .aspectRatio(contentMode: .fit)
            Image(.home14)
                .resizable()
                .frame(maxWidth: .infinity)
                .aspectRatio(contentMode: .fit)
            
        }
    }
    
    
    
    
    // 잠깐 Card 간단하게 만들 때 쓴 코드~
    /*private func makeDessertCard(_ model: DessertModel) -> some View {
        VStack(spacing: 10) {
            Image(model.imageName)
                .resizable()
                .frame(width: 130, height: 130)
            Text(model.title)
                .font(.MainTextSemiBold14)
                .foregroundStyle(.black02)
        }
    }*/
    
    
        

    
}

struct HomeView_Preview: PreviewProvider {
    static var devices = ["iPhone 11", "iPhone 16 Pro Max"]
    
    static var previews: some View {
        ForEach(devices, id: \.self) { device in
            HomeView()
                .previewDevice(PreviewDevice(rawValue: device))
                .previewDisplayName(device)
        }
    }
}
