//
//  WhatsNew.swift
//  StarbuckApp
//
//  Created by 박병선 on 4/3/25.
//

/*import SwiftUI

struct WhatsNewView: View {
    var body: some View {
        Text("새로운 소식")
    }
}
*/
import SwiftUI
struct WhatsNewView: View {
    @StateObject private var viewModel = WhatsNewViewModel()

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("What's New")
                .font(.mainTextBold24)
                .foregroundStyle(Color("black03"))
                .padding(.horizontal, 20)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(viewModel.adItems) { ad in
                      AdCardView(ad: ad)
                    }
                }
                .padding(.horizontal, 20)
            }
        }
    }
}

#Preview {
    WhatsNewView()
}

/*import SwiftUI
 
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
 
 /*Group {
  Text("\(viewModel.nickname)님")
  .foregroundColor(Color("brown01"))
  + Text("을 위한 추천메뉴")
  .foregroundColor(Color("black03"))
  }
  .font(.mainTextBold24)
  .padding(.leading, 20)*/
 
 ScrollView(.horizontal, showsIndicators: false) {
 HStack(spacing: 50) {
 ForEach(viewModel.recommendMenus) { menu in
 CircleImageCard(menu: menu)
 }
 }
 .padding(.horizontal, 20)
 .padding(.top, 20)
 }
 }
 }
 }
 */
