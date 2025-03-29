//
//  SignUpView.swift
//  cloneStarbucks
//
//  Created by tokkislove on 3/29/25.
//

import SwiftUI

struct SignUpView: View {
    @Bindable var viewModel: SignUpViewModel = .init()
    
    var body: some View {
        VStack {
            textFieldView
            Spacer()
            Button(action:  {
                viewModel.saveToAppStorage()
            }, label: {
                Text("생성하기")
                    .foregroundStyle(.white)
                    .font(.MainTextMedium16)
                    .frame(maxWidth: .infinity, minHeight: 46)
                    .background(.green01)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
            })
        }
        .padding(.horizontal, 20)
        .padding(.top, 210)
        .padding(.bottom, 72)
    }
    
    private var textFieldView: some View {
        let fields: [(label: String, binding: Binding<String>)] = [("닉네임", $viewModel.nickname), ("이메일", $viewModel.email), ("비밀번호", $viewModel.pwd)]
        return VStack(alignment: .center, spacing: 47) {
            ForEach(fields, id: \.label) { field in
                CustomUnderlineTextField(placeholder: field.label, text: field.binding)
            }
        }
    }
}




struct SignUpView_Preview: PreviewProvider {
    static var devices = ["iPhone 11", "iPhone 16 Pro Max"]
    
    static var previews: some View {
        ForEach(devices, id: \.self) { device in
            SignUpView()
                .previewDevice(PreviewDevice(rawValue: device))
                .previewDisplayName(device)
        }
    }
}
