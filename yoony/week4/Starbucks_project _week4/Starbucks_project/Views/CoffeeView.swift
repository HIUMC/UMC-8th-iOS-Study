//
//  CoffeeView.swift
//  Starbucks_project
//
//  Created by Yoonseo on 4/3/25.
//
import SwiftUI

struct CoffeeView: View {
    let coffee: Coffee
    
    var body: some View {
        VStack {
            Image(coffee.image)
                .resizable()
                .frame(width: 100, height: 100)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .clipShape(Circle())
            
            Text(coffee.name)
                .font(.mainTextRegular14)
                .foregroundColor(.black)
        }
    }
}


struct CoffeeListView: View {
    @StateObject private var viewModel = CoffeeViewModel()
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 16) {
                ForEach(viewModel.coffees) { coffee in
                    NavigationLink(destination: CoffeeInfoView(coffee: coffee)) {
                        CoffeeView(coffee: coffee)
                        
                    }
                }
                //.padding()
                
                
            }
        }
    }
}
#Preview {
    CoffeeListView()
}

