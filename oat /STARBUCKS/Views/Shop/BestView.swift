//
//  BestView.swift
//  STARBUCKS
//
//  Created by 신민정 on 4/5/25.
//

import SwiftUI

struct BestView: View {
    @StateObject var NewModel = BestViewModel()
    var body: some View {
        ScrollView(.horizontal) {
            HStack{
                VStack(){
                    HStack(){
                        bestview(item: NewModel.Bestname[0])
                        Spacer().frame(height:61)
                        bestview(item: NewModel.Bestname[1])
                    }
                    Spacer().frame(height:54)
                    HStack {
                        bestview(item: NewModel.Bestname[2])
                        Spacer().frame(height:61)
                        bestview(item: NewModel.Bestname[3])
                        
//                        VStack(alignment: .leading){
//                            Spacer().frame(height:17)
//                            Image(NewModel.Bestname[3].imageName)
//                            Spacer().frame(height: 12)
//                            Text(NewModel.Bestname[3].title)
//                                .font(.mainTextSemibold14)
//                        }
                    }
                }
                .padding(.horizontal)
                .frame(width: UIScreen.main.bounds.width)
                
                VStack {
                    HStack{
                        bestview(item: NewModel.Bestname[4])
                        Spacer().frame(height:61)
                        bestview(item: NewModel.Bestname[5])
                    }
                    Spacer().frame(height:54)
                    HStack{
                        bestview(item: NewModel.Bestname[6])
                        Spacer().frame(height:61)
                        bestview(item: NewModel.Bestname[7])
                    }
                }
                .padding(.horizontal)
                .frame(width: UIScreen.main.bounds.width)
            }
        }
        .scrollTargetBehavior(.paging)
        .scrollIndicators(.hidden)
    }
}

#Preview {
    BestView()
}


struct bestview : View {
    var item: best
    var body: some View {
        VStack() {
            Image(item.imageName)
                .scaledToFit()
            Spacer().frame(height: 12)
            Text(item.title)
                .frame(maxWidth: .infinity) //, alignment: .leading)
                .font(.mainTextSemibold14)
                .frame(width:175, alignment: .leading)
                
        }
    }
}
