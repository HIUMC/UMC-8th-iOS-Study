
import SwiftUI

struct LoginView: View {
    var body: some View {
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
    VStack(alignment: .leading) {
        Text("아이디")
            .font(.PretendardRegular13)
            .foregroundStyle(Color.idPwdBlack)
            .kerning(-0.65)
            //.padding(.bottom, 1.98)
        
        Spacer().frame(height: 1.98)
        
        Divider()
            //.padding(.bottom, 47)
        Spacer().frame(height: 47)
        
        Text("비밀번호")
            .font(.PretendardRegular13)
            .foregroundStyle(Color.idPwdBlack)
            .kerning(-0.65)
        
        Spacer().frame(height: 1.98)
        
        Divider()
        
        Spacer().frame(height: 47)
            //.padding(.bottom, 47)
        
        Button(action: {}, label: {
            Text("로그인하기")
                .font(.PretendardMedium16)
                .frame(maxWidth: .infinity, minHeight: 46) //크기 정하고 배경 정하고 코너 깎기
                .background(Color.loginButtonGreen)
                .foregroundStyle(.white)
                .cornerRadius(20)
            
                
        })
        
    }
    
    
}

//로그인 부분
private var loginGroup: some View {
    VStack(alignment: .center) {
        
        
        Text("이메일로 회원가입하기")
            .font(.PretendardRegular12)
            .foregroundStyle(Color.emailLoginGray)
            .underline()
            .frame(maxWidth:.infinity)
            .multilineTextAlignment(.center) //필요한가?
            .padding(.bottom, 19)
        //Spacer().frame(height: 19)
        
        HStack {
            Spacer()
            Image("KakaoLogin")
                .resizable()
                .frame(width: 306, height: 45)
                .aspectRatio(contentMode: .fit)
            Spacer()
        }
        .padding(.bottom, 19)
        //Spacer().frame(height: 19)
        
        HStack {
            Spacer()
            Image("AppleLogin")
                .resizable()
                .frame(width: 306, height: 45)
                .aspectRatio(contentMode: .fit)
            Spacer()
        }
        
    }

}




#Preview {
    LoginView()
}
