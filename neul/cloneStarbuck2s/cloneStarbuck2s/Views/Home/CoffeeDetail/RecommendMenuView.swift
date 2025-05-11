//
//  RecommendMenuView.swift
//  cloneStarbucks
//
//  Created by tokkislove on 4/3/25.
//
import SwiftUI

struct RecommendMenuView: View {
    @EnvironmentObject var router: NavigationRouter
    @Binding var viewModel: CoffeeDetailViewModel
    @AppStorage("nickname") private var nickname: String = "(설정 닉네임)"
    
    var body: some View {
        VStack(spacing: 25) {
            HStack(spacing: 2) {
                Group {
                    Text("\(nickname)")
                        .foregroundStyle(.brown01)
                    Text("님을 위한 추천 메뉴")
                        .foregroundStyle(.black03)
                }
                .font(.MainTextBold24)
                Spacer()
                
            }
            ScrollView(.horizontal) {
                LazyHStack(spacing: 15) {
                    ForEach(Array(viewModel.recoCoffees.enumerated()), id: \.element) { index, coffee in
                        CircleImageCard(imageName: coffee.imageName, title: coffee.title)
                            .onTapGesture {
                                let detail = viewModel.coffees[index]
                                router.push(.coffeeDetail(detail))

                            }
                    }
                }
            }
            .scrollIndicators(.hidden)
        }
    }
}


