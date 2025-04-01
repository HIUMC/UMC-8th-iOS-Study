//
//  AdvertiseView.swift
//  cloneStarbucks
//
//  Created by tokkislove on 3/29/25.
//

import SwiftUI

struct AdvertiseView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .center) {
                Image(.advertisement)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth: .infinity, maxHeight: 720)
                    .border(Color.red)
                
                Spacer()
                
                detailButton
                closeButton
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
        .ignoresSafeArea(edges: .vertical)
        
    }
    
    private var detailButton: some View {
        Button(action:  {
            print("자세히 보기")
        }, label: {
            Text("자세히 보기")
                .foregroundStyle(.white)
                .font(.MainTextMedium16)
                .frame(maxWidth: .infinity, minHeight: 58)
                .background(.green01)
                .clipShape(RoundedRectangle(cornerRadius: 20))
        })
        .padding(.horizontal, 20)
    }
    
    private var closeButton: some View {
        HStack {
            Spacer()
            
            Button(action:  {
                print("닫기 버튼 클릭")
                dismiss()
            }, label: {
                Text("X 닫기")
                    .foregroundStyle(.gray05)
                    .font(.MainTextLight14)
            })
            .padding(.top, 17)
            .padding(.trailing, 37)
            .padding(.bottom, 36)
        }
    }
    
}

struct AdvertiseView_Preview: PreviewProvider {
    static var devices = ["iPhone 11", "iPhone 16 Pro Max"]
    
    static var previews: some View {
        ForEach(devices, id: \.self) { device in
            AdvertiseView()
                .previewDevice(PreviewDevice(rawValue: device))
                .previewDisplayName(device)
        }
    }
}

