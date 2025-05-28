//
//  LoginView.swift
//  UMC_Starbucks
//
//  Created by 이서현 on 3/30/25.
//


// Alamofire .. URLSession 이해가 부족해서 지피티 범벅이라..,,,공부 더 하고 수정해서 pr 올리고 싶었는데 생각보다 시간이 안 났어유,,ㅠ,ㅡ
//이번 주차 하기 전에 6주차 공부하고 스터디 때 들었던 피드백 반영해서 최대한 수정해서 오겠습니디ㅏ....
// 지금까지 계속 네비게이션 스택을 썼는데 지금이라도 라우터로 바꾸는 게 좋은지 궁금해요!!!


import SwiftUI
import Alamofire

struct LoginView: View {
    
    @State var viewModel = LoginViewModel()
    @State private var isLoginOK: Bool = false
    
    @FocusState private var isIdFocused: Bool // 포커스 상태 추적이라네..
    @FocusState private var isPwdFocused: Bool
    
    @Environment(\.openURL) private var openURL

    /*
    private var kakaoLoginURL: URL? {
        let restAPIKey = "4f1fb1b08be15e4edf1d71003fb065ba"
        let redirectURI = "http://kakao4f1fb1b08be15e4edf1d71003fb065ba://oauth"
        let urlString = "https://kauth.kakao.com/oauth/authorize?response_type=code&client_id=\(restAPIKey)&redirect_uri=\(redirectURI)"
        return URL(string: urlString)
    }
    */
    
    
    
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
            .navigationDestination(isPresented: $isLoginOK) {
                TabBarView()
            }
            .onAppear {
                if let token = KeychainService.shared.loadTokenInfo() {
                    print("Keychain에서 토큰 정보 불러옴: \(token)")
                    
                    // accessToken이 존재하면 로그인 성공 처리
                    if !token.accessToken.isEmpty {
                        // 닉네임 UserDefaults에도 저장
                        UserDefaults.standard.set(token.nickname, forKey: "nickname")
                        print("✅ 자동 로그인 시 닉네임 저장:", token.nickname)
                        
                        isLoginOK = true
                    }
                } else {
                    print("ℹ️ Keychain에 저장된 토큰 없음")
                }
            }
            .navigationBarBackButtonHidden(true)
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
            .focused($isIdFocused)
            //.foregroundStyle(Color.green00)
            Spacer().frame(height: 1.98)
            
            Rectangle()
                .frame(height: 0.7)
                .foregroundStyle(isIdFocused ? Color.loginButtonGreen : Color.gray00)
                
            /*
            Divider()
                .frame(height: 0.7) //🚨 왜 height 건드리는데 간격이 넓어짐?
             */
            
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
            .focused($isPwdFocused)
            
            Spacer().frame(height: 1.98)
            Rectangle()
                .frame(height: 0.7)
                .foregroundStyle(isPwdFocused ? Color.loginButtonGreen : Color.gray00)
            //Divider()는 색 추가가 어려워서 Rectangle 크기 조절하는 걸로
            
            Spacer().frame(height: 47)
            
            Button(action: {
                let token = TokenInfo(
                    accessToken: viewModel.id,
                    refreshToken: viewModel.pwd,
                    nickname: viewModel.nickname
                )
                KeychainService.shared.saveToken(token)

                if viewModel.nickname.isEmpty {
                    if let saved = KeychainService.shared.loadTokenInfo() {
                        UserDefaults.standard.set(saved.nickname, forKey: "nickname")
                        print("Keychain에서 닉네임 가져와 저장:", saved.nickname)
                    }
                } else {
                    UserDefaults.standard.set(viewModel.nickname, forKey: "nickname")
                    print("직접 입력한 닉네임 저장:", viewModel.nickname)
                }

                isLoginOK = true
            }) {
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
                Button(action: {
                    viewModel.kakaoLogin {
                        isLoginOK = true
                    }
                }) {
                    Image("kakaoLogin")
                        .resizable()
                        .frame(width: 306, height: 45)
                        .aspectRatio(contentMode: .fit)
                }
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




// WebView 를 만들어서..?? 띄워봐라 ? 리다이렉트 핸들링 -> 사용하기?
// SDK  구현해보기
