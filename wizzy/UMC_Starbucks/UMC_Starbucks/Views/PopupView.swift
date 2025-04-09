//
//  PopupView.swift
//  UMC_Starbucks
//
//  Created by 이서현 on 3/30/25.
//

import SwiftUI

struct PopupView: View {
    @State private var showSheet = false
    @Binding var showPopup: Bool
    //@Environment(\.dismiss) private var dismiss
    
    var body: some View {
        GeometryReader { geometry in
            /*
             VStack() {
             //.frame(maxWidth: .infinity, maxHeight: 720)
             Image("PopupImage")
             .resizable()
             //.padding(.bottom, 106)
             .aspectRatio(contentMode: .fill)
             .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: 720)
             .ignoresSafeArea()
             //.padding(.bottom, 40)
             //Spacer().frame(height: 100)
             
             //Spacer()
             detailButton
             //Spacer()
             closeButton
             //Spacer()
             }
             .frame(width: geometry.size.width, height: geometry.size.height)
             
             } //v
             .ignoresSafeArea()
             */
            VStack(spacing: 0) {
                Image("PopupImage") // 위쪽 이미지
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: 720)
                    .ignoresSafeArea()
                
                // 아래 흰색 박스 영역
                VStack(spacing: 0) {
                    Spacer()
                    detailButton
                        //.padding(.top, 106)
                    Spacer()
                    closeButton
                        //.padding(.top, 72)
                        .padding(.bottom, 36)
                }
                //.frame(maxWidth: .infinity)
                .background(Color.white)
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
            
        }
        .ignoresSafeArea(edges: .vertical)
    }
    
    
    private var detailButton: some View {
        
        Button(action: {
            print("자세히 보기")
        }) {
            Text("자세히 보기")
                .font(.PretendardMedium16)
                .frame(width: 402, height: 58)
                .background(Color.loginButtonGreen)
                .foregroundStyle(.white)
                .clipShape(RoundedRectangle(cornerRadius: 20))
        }
    }
    
    
    private var closeButton: some View {
        HStack {
            Spacer()
            Button(action: {
                print("닫기")
                //dismiss()
                showPopup = false
                
            }) {
                Text("X 닫기")
                    .font(.PretendardLight14)
                    .foregroundStyle(Color.popupGray)
            }
            .padding(.trailing, 19)
        } // h
    }
    

} // struct
struct PopupView_Previews: PreviewProvider {
    static var previews: some View {
        StatefulPreviewWrapper(true) { binding in
            PopupView(showPopup: binding)
        }
    }
}

struct StatefulPreviewWrapper<Value, Content: View>: View {
    @State var value: Value
    var content: (Binding<Value>) -> Content

    init(_ value: Value, content: @escaping (Binding<Value>) -> Content) {
        _value = State(initialValue: value)
        self.content = content
    }

    var body: some View {
        content($value)
    }
}

