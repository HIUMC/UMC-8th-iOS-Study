//
//  DessertView.swift
//  STARBUCKS
//
//  Created by 신민정 on 3/28/25.
//

import SwiftUI

struct DessertView: View {
    @StateObject var dessertViewModel = DessertViewModel()
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack(spacing:16) {
                ForEach(dessertViewModel.Dessertname) {
                    menu in CircleImageCard(imageName: menu.imageName)
                }
            }
        }
        .padding()
    }

}

#Preview {
    DessertView()
}
