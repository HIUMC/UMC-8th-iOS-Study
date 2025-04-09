//
//  WhatsNewView.swift
//  UMC_Starbucks
//
//  Created by 이서현 on 4/3/25.
//


 import SwiftUI
 
struct WhatsNewView: View {
    @StateObject var whatsnewViewModel = WhatsnewViewModel()
    
    var body: some View {
        VStack {
            HStack {
                Text("What's New")
                    .font(.PretendardBold24)
                    .foregroundStyle(Color.black03)
                    .kerning(-0.5)
                    .padding(.leading, 19)
                Spacer()

            }
            .padding(.top, 20)
            
            ScrollView(.horizontal) {
                LazyHStack(alignment: .top, spacing: 15) {
                    ForEach(whatsnewViewModel.WhatsNewData) { news in
                        NavigationLink {
                        } label : {
                            WhatsNewCard(imageName: news.imageName, newsTitle: news.newsTitle, newsContent: news.newsContent)
                        }
                        
                        
                        
                    }
                }
            }
            .padding(.horizontal)
        }
        .frame(height: 300)
    }
    
}
 #Preview {
 WhatsNewView()
 }
 
