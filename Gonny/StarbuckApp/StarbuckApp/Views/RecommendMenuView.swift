//
//  RecommendView.swift
//  StarbuckApp
//
//  Created by 박병선 on 4/3/25.
//
/*import SwiftUI

struct RecommendMenuView: View {
    var body: some View {
        Text("추천 메뉴")
    }
}
*/

import SwiftUI
import Foundation

 struct RecommendMenuView: View {
     @StateObject private var viewModel = RecommendMenuViewModel()

     var body: some View {
         VStack(alignment: .leading, spacing: 8) {
             Group{
                 Text(viewModel.nickname.isEmpty ? "(설정닉네임)" : viewModel.nickname)
                     //.font(.mainTextBold24)
                     .foregroundColor(Color("brown01"))
                 + Text("을 위한 추천메뉴")
                     //.font(.mainTextBold24)
                     .foregroundColor(Color("black03"))
             }
             
             .font(.mainTextBold24)
             .padding(.leading, 20)
             
             ScrollView(.horizontal, showsIndicators: false) {
                 HStack(spacing: 50) {
                     ForEach(viewModel.recommendMenus) { menu in
                         CircleImageCard(item: menu)
                         
                     }
                 }
                 .padding(.leading, 40)
                 .padding(.top, 20)
             }
         }
     }
 }



#Preview {
    RecommendMenuView()
}
 
