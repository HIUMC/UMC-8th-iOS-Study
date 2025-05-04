//
//  AllMenuView.swift
//  cloneStarbucks
//
//  Created by tokkislove on 4/28/25.
//
import SwiftUI

struct AllMenuView: View {
    @State private var selectedMenu: String = "음료"
    @State var viewModel = OrderViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            selectMenu
                .padding(.horizontal, 27)
            Divider()
            if selectedMenu == "음료" {
                drinkMenus
            } else {
                Spacer()
            }
            
        }
    }
    
    private var selectMenu: some View {
        HStack(spacing: 10) {
            Button(action: {
                selectedMenu = "음료"
            }, label: {
                HStack(spacing: 1) {
                    Text("음료")
                        .foregroundStyle(selectedMenu == "음료" ? .black01 : .gray04)
                        .font(.MainTextSemiBold16)
                    Image("new")
                        .resizable()
                        .frame(width: 16, height: 16)
                }
            })
            Button(action: {
                selectedMenu = "푸드"
            }, label: {
                HStack(spacing: 1) {
                    Text("푸드")
                        .foregroundStyle(selectedMenu == "푸드" ? .black01 : .gray04)
                        .font(.MainTextSemiBold16)
                    Image("new")
                        .resizable()
                        .frame(width: 16, height: 16)
                }
            })
            Button(action: {
                selectedMenu = "상품"
            }, label: {
                HStack(spacing: 1) {
                    Text("상품")
                        .foregroundStyle(selectedMenu == "상품" ? .black01 : .gray04)
                        .font(.MainTextSemiBold16)
                    Image("new")
                        .resizable()
                        .frame(width: 16, height: 16)
                }
            })
            Spacer()
        }
        .padding(.vertical, 10)
    }
    
    private var drinkMenus: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(spacing: 26) {
                ForEach(viewModel.drinks, id: \.id) { item in
                    HStack(spacing: 16) {
                        Image(item.imageName)
                            .resizable()
                            .clipShape(Circle())
                            .frame(width: 60, height: 60)
                        VStack(alignment: .leading) {
                            Text(item.title)
                                .font(.MainTextSemiBold16)
                                .foregroundStyle(Color.gray06)
                            Text(item.descrip)
                                .font(.MainTextSemiBold13)
                                .foregroundStyle(Color.gray03)
                        }
                        Spacer()
                    }
                }
            }
            .padding(.vertical, 19)
        }
        .padding(.horizontal, 23)
    }
}


#Preview {
    AllMenuView()
}
