//
//  AdView.swift
//  UMC-iOS-Starbucks
//
//  Created by 곽은채 on 3/30/25.
//

import SwiftUI

struct AdView: View {
    @EnvironmentObject private var router: NavigationRouter
    
    var body: some View {
        VStack {
            Image(.ad)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: .infinity, maxHeight: 720)
            Spacer()
            bottom
        }
        .padding(.top, 0)
        .padding(.bottom, 36)
        .ignoresSafeArea()
        .toolbarVisibility(.hidden)
    }
    
    private var bottom: some View {
        VStack(alignment: . trailing, spacing: 19) {
            NavigationLink(destination: AdDetailView()) {
                Text("자세히 보기")
                    .font(.mainTextMedium16)
                    .foregroundStyle(Color("white01"))
                    .frame(maxWidth: .infinity, maxHeight: 58)
                    .background() {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color("green01"))
                            .frame(height: 58)
                    }
            }
            
            Button(action: {
                router.push(.login)
            }, label: {
                Text("X 닫기")
                    .font(.mainTextLight14)
                    .foregroundStyle(Color("gray05"))
            })
        }
        .padding(.horizontal, 18)
    }
}

#Preview {
    AdView()
}

struct AdDetailView: View {
    var body: some View {
        ZStack {
            Color("green03")
            
            Text("Ad Detail View")
                .font(.mainTextBold24)
                .foregroundStyle(Color("white00"))
        }
        .ignoresSafeArea()
    }
}
