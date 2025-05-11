//
//  NewProductsView.swift
//  Starbucks
//
//  Created by 김영택 on 4/10/25.
//
import SwiftUI

struct NewProductsView: View {
    
    @StateObject var viewModel = NewProductsViewModel()
    
    let columns = Array(repeating: GridItem(.flexible()), count: 2)
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("New Products")
                .font(.PretendardSemibold22)
            Spacer().frame(height: 16)
            
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(viewModel.newproducts, id: \.self) {menu in
                        VStack{
                            Image(menu.newProductsImageName)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 157, height: 156)
                                .clipped()
                            Spacer().frame(height: 10)
                            
                            Text(menu.newProductsName)
                                .font(.PretendardSemibold14)
                        }
                    }
                }
            }
        }.padding(.leading, 20)
    }
}


#Preview {
    NewProductsView()
}
