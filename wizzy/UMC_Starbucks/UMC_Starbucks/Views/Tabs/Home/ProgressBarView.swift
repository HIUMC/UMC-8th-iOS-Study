//
//  ProgressBarView.swift
//  UMC_Starbucks
//
//  Created by 이서현 on 4/3/25.
//

import SwiftUI

struct ProgressBarView: View {
    var body: some View {
                VStack (alignment: .leading)  { //v2
                    Text("골든 미모사 그린 티와 함께 \n행복한 새해의 축배를 들어요!")
                        .font(.PretendardBold24)
                        .foregroundStyle(Color.black03)
                        .multilineTextAlignment(.leading)
                        .kerning(-0.5)
                        .padding(.top, 145)
                    
                    HStack { // h1
                        VStack (alignment: .leading) {
                            HStack {
                                Text("11★ until next Reward")
                                    .font(.PretendardSemiBold16)
                                    .foregroundStyle(Color.brown02)
                                Spacer()
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.top, 29)
                            ZStack { //z2 바
                                HStack {
                                    RoundedRectangle(cornerRadius: 4)
                                        .frame(width: 250, height: 8)
                                        .foregroundStyle(Color.gaugeBarGray)
                                    Spacer()
                                }
                                HStack { //h2
                                    RoundedRectangle(cornerRadius: 4)
                                        .frame(width: 110, height: 8)
                                        .foregroundStyle(Color.brown02)
                                    Spacer()
                                } // h2
                            } // z2
                        }
                        
                        VStack {
                            HStack{
                                Spacer()
                                Button {
                                    print("내용 보기")
                                } label: {
                                    Text("내용 보기")
                                        .font(.PretendardRegular13)
                                        .kerning(-0.5)
                                        .foregroundStyle(Color.gray66)
                                }
                                
                                Image("vector")
                                    .scaledToFit()
                            }// h
                            .padding(.trailing, 10)
                            .padding(.bottom, -10)
                            
                            HStack { // 1/12
                                Text("1")
                                    .font(.PretendardSemiBold38)
                                    .foregroundStyle(Color.black03)
                                
                                Text("/")
                                    .font(.PretendardLight24)
                                    .foregroundStyle(Color.grayC9)
                                
                                Text("12★")
                                    .font(.PretendardSemiBold24)
                                    .foregroundStyle(Color.brown02)
                            } // h
                           
                        }
                        .padding(.top, 25)
                        
                    } // h1
                    
                } //v2
                .padding(.horizontal, 19)
                //.padding(.bottom, 3)
                
            } //z1
        
    }




#Preview {
    ProgressBarView()
}
