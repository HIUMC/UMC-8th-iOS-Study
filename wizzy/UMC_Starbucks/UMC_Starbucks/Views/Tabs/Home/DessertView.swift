//
//  DessertView.swift
//  UMC_Starbucks
//
//  Created by 이서현 on 4/3/25.
//

import SwiftUI

struct DessertView: View {
    @StateObject var dessertViewModel: DessertViewModel = DessertViewModel()
    
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("하루가 달콤해지는 디저트")
                .font(.PretendardSemiBold24)
                .foregroundStyle(Color.black03)
                .padding(.bottom, 5)
                .padding(.horizontal, 10)
            
            ScrollView(.horizontal) {
                LazyHStack(spacing: 15) {
                    ForEach(dessertViewModel.DessertList) { menu in
                        CircleImageCard(
                            imageName: menu.imageName, coffeetitle: menu.dessertName
                        )
                        
                    }
                }
                .frame(height: 180)
            }
            
        } //v
    }
}

#Preview {
    DessertView()
}
