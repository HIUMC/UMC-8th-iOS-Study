//
//  SignupView.swift
//  Starbucks_Week1_gogo
//
//  Created by 고석현 on 4/1/25.
//

import SwiftUI

struct SignupView: View {
    
    @StateObject var viewModel :SignupViewModel = .init()
    @Environment(\.dismiss) private var dismiss
    //SignupViewModel에서 클래스 가져와서 초기화 객체 viewModel이라는 놈 생성. @StateObject로 객체 주기 관리~ 변경 사항 렌더링 후 유지. viewModel 은 SignupViewModel 클래스의 객체니까 관련된 프로퍼티 및 메소드 이용 가능.
    
    //loginview 처럼 필드 입력할 떄. 초록샌 라인 이쁘게 나오게 함.
    @FocusState private var focusedField: Field?
        private enum Field {
            case email, pwd ,nickname
        }
    
    
      
        
    

    

    
        var body: some View {
        VStack {
            midSection
            //버튼 밑에 있으니까 쭈우욱 Spacer
            Spacer()
            
            Button(action: {
                if viewModel.isValidInput {
                    print("생성하기 버튼 클릭됨")
                    viewModel.saveStorage()
                    dismiss()
                } else {
                    print("입력값이 부족합니다.")
                }
            }, label:{
                Text("생성하기")
                    .font(.PretendardMedium18)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, minHeight: 58, maxHeight: 58)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(.green01)
                    )
            })
        }
        
        .padding(.top,210)
        .padding(.horizontal,19)
        .navigationTitle("회원가입")
        
    }
    
    private var midSection: some View {
            VStack(alignment: .leading, spacing: 49) {
                TextField("닉네임", text: $viewModel.signupModel.nickname)
                    .font(.PretendardRegular18)
                    .foregroundStyle(.black01)
                    .autocapitalization(.none) //자꾸 대문자로 시작하는거 없애자 일단
                    .focused($focusedField, equals: .nickname)
                 
                    .overlay(alignment: .bottom, content: {
                        Divider()
                            .frame(height: 1)
                            .background(Color.gray00)
                            .overlay(focusedField == .nickname ? Color.green01 : Color.gray01)
                        //Divider()를 overlay 하위 항목으로 !
                            
                    })
                
                TextField("이메일", text: $viewModel.signupModel.email)
                    .foregroundStyle(.black01)
                    .font(.PretendardRegular18)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .focused($focusedField, equals: .email)
                
                    
                    .overlay(alignment: .bottom) {
                        Divider()
                            .frame(height: 1)
                            .background(Color.gray00)
                            . overlay(focusedField == .email ? Color.green01 : Color.gray01)
                            
                    }
                
                TextField("비밀번호", text: $viewModel.signupModel.password)
                    .font(.PretendardRegular18)
                    .foregroundStyle(.black01)
                    .autocapitalization(.none)
                    .focused($focusedField, equals: .pwd)
                  
                    .overlay(alignment: .bottom) {
                        Divider()
                            .frame(height: 1)
                            .background(Color.gray00)
                            .overlay(focusedField == .pwd ? Color.green01 : Color.gray01)
                            
                    }
            }
        }
    }


#Preview {
    SignupView()
}
