//
//  LoginView.swift
//  UMC_Starbucks
//
//  Created by 이서현 on 3/30/25.
//

import SwiftUI

struct LoginView: View {
    
    @State var viewModel = LoginViewModel()
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Spacer().frame(height: 104)
                mainTitleGroup
                Spacer()
                idPwdGroup
                Spacer()
                loginGroup
                
            }
            
            .padding(.horizontal, 19)
            //.ignoresSafeArea(edges: .top)
        }
        
    }
    
    
    //상단 title
    private var mainTitleGroup: some View {
        VStack(alignment: .leading) {
            Image("Starbucks")
                .resizable()
                .frame(width: 97, height: 95)
                .aspectRatio(contentMode: .fit)
            //.padding(.bottom, 28)
            Spacer().frame(height: 28)
            
            Group {
                Text("안녕하세요.")
                Text("스타벅스입니다.")
            }
            .font(.PretendardExtraBold24)
            .foregroundStyle(Color.black)
            .kerning(1.2)
            
            
            Spacer().frame(height: 19)
            
            Text("회원 서비스 이용을 위해 로그인 해주세요")
                .font(.PretendardMedium16)
                .foregroundStyle(Color.loginGray)
                .kerning(-0.8)
            
            
            
        }
    }
    
    //아이디 입력 및 비밀번호 입력
    private var idPwdGroup: some View {
        
        
        return VStack(alignment: .leading) {
            //.padding(.bottom, 1.98)
            
            //Spacer().frame(height: 1.98)
            
            TextField(
                "아이디", // 접근성용
                text: $viewModel.id,
                prompt: Text("아이디")
                    .font(.PretendardRegular13)
                    .foregroundStyle(Color.idPwdBlack)
                    .kerning(-0.65)
            )
            
            
            Divider()
                .frame(height: 0.7) //🚨 왜 height 건드리는데 간격이 넓어짐?
            
            /*
             Divider 틀의 높이를 0.7로 설정해서 위 텍스트(아이디)와 간격이 벌어짐
             */
            
            //.padding(.bottom, 47)
            Spacer().frame(height: 47)
            
            
            TextField(
                "비밀번호", // 접근성용
                text: $viewModel.pwd,
                prompt: Text("비밀번호")
                    .font(.PretendardRegular13)
                    .foregroundStyle(Color.idPwdBlack)
            )
            
            Spacer().frame(height: 1.98)
            
            Divider()
            
            Spacer().frame(height: 47)
            //.padding(.bottom, 47)
            
            Button(action: {}) {
                Text("로그인하기")
                    .font(.PretendardMedium16)
                    .frame(maxWidth: .infinity, minHeight: 46) //크기 정하고 배경 정하고 코너 깎기
                    .background(Color.loginButtonGreen)
                    .foregroundStyle(.white)
                //.cornerRadius(20) => 🚨 clipshape로 ! deprecated
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                // 🐱 clipShape 쓰면 다른 도형으로 바꾸기도 쉽고 테두리도 넣고 좋아용
                
            }
            
        }
        
        
    }
    
    //로그인 부분
    private var loginGroup: some View {
        return VStack(alignment: .center) {
            NavigationLink(destination: SignupView()) {
                Text("이메일로 회원가입하기")
                    .font(.PretendardRegular12)
                    .foregroundStyle(Color.emailLoginGray)
                    .underline()
                    .frame(maxWidth:.infinity)
                    .multilineTextAlignment(.center) //필요한가?
                    .padding(.bottom, 16)
            }
            
            
            
            HStack {
                Spacer()
                Image("KakaoLogin")
                    .resizable()
                    .frame(width: 306, height: 45)
                    .aspectRatio(contentMode: .fit)
                Spacer()
            }
            .padding(.bottom, 16)
            //Spacer().frame(height: 16)
            
            HStack {
                Spacer()
                Image("AppleLogin")
                    .resizable()
                    .frame(width: 306, height: 45)
                    .aspectRatio(contentMode: .fit)
                Spacer()
            }
            //Spacer().frame(height: 68)
        }
            
        }
        
    }



struct SwiftUIView_Preview: PreviewProvider {
    static var devices = ["iPhone 11", "iPhone 16 Pro"]
    
    static var previews: some View {
        ForEach(devices, id: \.self) { device in
            LoginView()
                .previewDevice(PreviewDevice(rawValue: device))
                .previewDisplayName(device)
        }
    }
}
