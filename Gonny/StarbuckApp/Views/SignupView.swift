//
//  SignupView.swift
//  StarbuckApp
//
//  Created by 박병선 on 3/30/25.
//
/*
 @AppStorage("nickname") private var savedNickname = ""
    @AppStorage("email") private var savedEmail = ""
    @AppStorage("password") private var savedPassword = ""

    var body: some View {
        VStack(alignment: .leading) {
            VStack(spacing: 49){
                TextField("닉네임", text: $viewModel.nickname)
                    .font(.mainTextRegular18)
                    .foregroundColor(Color("gray02"))
                
                TextField("이메일", text: $viewModel.email)
                    .font(.mainTextRegular18)
                    .foregroundColor(Color("gray02"))
                
                TextField("비밀번호", text: $viewModel.password)
                    .font(.mainTextRegular18)
                    .foregroundColor(Color("gray02"))
            }
            .padding(.top, 172)

            Spacer()

            Button(action: {
                // 여기서 직접 저장
                savedNickname = viewModel.nickname
                savedEmail = viewModel.email
                savedPassword = viewModel.password
            }) {
                Text("생성하기")
                    .font(.mainTextMedium16)
                    .foregroundColor(Color("white01"))
                    .padding(.horizontal, 171)
                    .padding(.vertical, 18.5)
            }
            .frame(width: 402, height: 58)
            .background(Color("green01"))
            .cornerRadius(10)
        }
 */

/*
 import SwiftUI

 struct UnderlineTextFieldView: View {
     @State private var text: String = ""
     @FocusState private var isFocused: Bool  // 포커스 상태 감지

     var body: some View {
         VStack(alignment: .leading, spacing: 8) {
             TextField("닉네임을 입력하세요", text: $text)
                 .focused($isFocused)
                 .textFieldStyle(.plain) // 기본 테두리 제거
                 .padding(.vertical, 8)

             Rectangle()
                 .frame(height: 1)
                 .foregroundColor(isFocused ? Color("green01") : Color("gray02")) // 포커스 상태에 따라 색 변경
                 .animation(.easeInOut, value: isFocused) // 부드럽게 변경
         }
         .padding()
     }
 }
*/

import SwiftUI
import Observation

struct SignupView: View {
    
    //Appstorage 저장소(->ObservableObject로 해야되는거야..???)
    @AppStorage("nickname") private var savedNickname=""
    @AppStorage("email") private var savedEmail=""
    @AppStorage("password") private var savedPassword=""
    
    @Binding private var viewModel : SignupViewModel
    
    /*init(viewModel: SignupViewModel = SignupViewModel()) {
            self._viewModel = Bindable(wrappedValue: viewModel)
        }*/
    
    /*import SwiftUI
     
     struct UnderlineTextFieldView: View {
         @State private var text: String = ""
         @FocusState private var isFocused: Bool  // 포커스 상태 감지

         var body: some View {
             VStack(alignment: .leading, spacing: 8) {
                 TextField("닉네임을 입력하세요", text: $text)
                     .focused($isFocused)
                     .textFieldStyle(.plain) // 기본 테두리 제거
                     .padding(.vertical, 8)

                 Rectangle()
                     .frame(height: 1)
                     .foregroundColor(isFocused ? Color("green01") : Color("gray02")) // 포커스 상태에 따라 색 변경
                     .animation(.easeInOut, value: isFocused) // 부드럽게 변경
             }
             .padding()
         }
     }*/
        // @FocusState private var isFocused: Bool
    var body: some View {
        VStack(alignment: .leading) {
            VStack(spacing: 49){
                TextField("닉네임", text: $viewModel.nickname)
                    .font(.mainTextRegular18)
                    //.foregroundColor(Color("gray02"))
                   //.focused($isFocused)
                  // .textFieldStyle(.plain)
                //.padding(.vertical,8)
                //초록색 커서 도전해봤으나 개같이 실패
               // Rectangle()
                 //   .frame(height:1)
                    //.foregroundColor(isFocused? Color("green01"):Color("gray02"))
                TextField("이메일", text: $viewModel.email)
                    .font(.mainTextRegular18)
                    .foregroundColor(Color("gray02"))
                
                
                TextField("비밀번호", text: $viewModel.password)
                    .font(.mainTextRegular18)
                    .foregroundColor(Color("gray02"))
                
            }
            .padding(.top,172)
            
            Spacer()
            Button(action: {
                let user = viewModel.saveUser()
                savedNickname = user.nickname
                savedEmail = user.email
                savedPassword = user.password
            }) {
                Text("생성하기")
                    .font(.mainTextMedium16)
                    .foregroundColor(Color("white01"))
                    .padding(.vertical, 18.5)
            }
            // .padding(.horizontal, 20)
            //.padding(.top, 210)
            //.padding(.bottom, 72)
            .frame(maxWidth: .infinity, minHeight: 48)
            //.frame(width:402, height: 58)
            .background(Color("green01"))
            .padding(.top, 210)
            .padding(.bottom, 72)
            .clipShape(RoundedRectangle(cornerRadius: 40))
            
            
        }
        
        
    }
            
            /*
            Button(action: {viewModel.saveUser()
            }) {
                Text("생성하기")
                    .font(.mainTextMedium16)
                    .foregroundColor(Color("white01"))
                    .padding(.horizontal, 171)
                    .padding(.vertical, 18.5)
            }
            .frame(width: 402, height: 58)
            .background(Color("green01"))
            .cornerRadius(10)
                
            
            
        }
        .padding(.bottom, 72)
    }*/
}



/*Button(action: {
 print("카카오 로그인 클릭됨")
}) {
 HStack {
     Image("kakaoLogo")
         .padding(.leading, 20)
     Spacer()
 }
 .overlay(alignment: .center, content: {
     Text("카카오 로그인")
         .foregroundStyle(.black.opacity(0.85))
         .font(.MainTextMedium16)
 })
 .frame(width: 306, height: 45)
 .background(Color(hex: "FEE500"))
 .clipShape(RoundedRectangle(cornerRadius: 5))
}

*/
        
        
        
#Preview {
    SignupView(viewModel: SignupViewModel())
}
