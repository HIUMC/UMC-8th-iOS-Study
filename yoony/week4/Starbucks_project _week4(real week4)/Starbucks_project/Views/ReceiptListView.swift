//
//  ReceiptList.swift
//  Starbucks_project
//
//  Created by Yoonseo on 4/13/25.
//

import SwiftUI

struct ReceiptList: View {
    @State private var isShowingImageViewer = false
    
    let model: ReceiptsModel
    
    init(model: ReceiptsModel) {
        self.model = model
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                contentView
                
                Spacer()
                
                showImageBtn
            }
            
            Divider()
                .frame(height: 1)
                .background(.grey02)
                .padding(.top, 14)
            
        }.padding(.horizontal, 16)
      
    }
    
 
    private var contentView: some View {
        func formattedDate(_ date: Date) -> String {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy.MM.dd HH:mm"
            formatter.locale = Locale(identifier: "ko_KR")
            return formatter.string(from: date)
        }
        
        return VStack(alignment: .leading, spacing: 9) {
            Text(model.store)
                .font(.PretendardSemiBold18)
                .foregroundStyle(.black)
            
            Text(formattedDate(model.createdAt))
                .font(.mainTextMedium16)
                .foregroundStyle(.grey03)
            
            Text("\(model.totalAmount)원")
                .font(.PretendardSemiBold18)
                .foregroundStyle(.brown02)
        }
    }
    
  
    private var showImageBtn: some View {
        Button(action: {
            print("이미지 보기")
            isShowingImageViewer = true
        }) {
            Image("receiptbtn")
        }
        .fullScreenCover(isPresented: $isShowingImageViewer, content: {
            ZStack(alignment: .topTrailing) {
                Color.black.opacity(0.8)
                    .ignoresSafeArea()
                
                HStack {
                    Spacer()
                    if let data = model.image?.photo,
                       let uiImage = UIImage(data: data)
                    {
                        Image(uiImage: uiImage)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding()
                    }
                    Spacer()
                }

                Button(action: {
                    print("닫기")
                    isShowingImageViewer = false
                }) {
                    Image("X")
                        .resizable()
                        .frame(width: 18, height: 18)
                        .foregroundColor(.grey04)
                        .padding(18)
                }
            }
           
        })
    }
}

#Preview {
    ReceiptList(model: ReceiptsModel(store: "사당역점", totalAmount: 6500))
}
