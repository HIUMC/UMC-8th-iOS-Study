
import SwiftUI

struct LoginView: View {
    var body: some View {
        VStack(alignment: .leading) {

            mainTitleGroup
            Spacer().frame(height: 104)
            idPwdGroup
            Spacer().frame(height: 47)
            loginGroup
        }

    }
}

//상단 title
private var mainTitleGroup: some View {
    VStack(alignment: .leading) {
        Image("Starbucks")
            .resizable()
            .frame(width: 97, height: 95)
            .aspectRatio(contentMode: .fit)
        
        Spacer().frame(height: 28)
        
        
        Text("안녕하세요.")
            .font(.PretendardExtraBold24)
            .kerning(1.2)
        Text("스타벅스입니다.")
            .font(.PretendardExtraBold24)
            .kerning(1.2)
        
        Spacer().frame(height: 19)
        
        Text("회원 서비스 이용을 위해 로그인 해주세요")
            .font(.PretendardMedium16)
            .foregroundStyle(Color.loginGray)
        
        
    }
}

//아이디 입력 및 비밀번호 입력
private var idPwdGroup: some View {
    VStack(alignment: .leading) {
        Text("아이디")
            .font(.PretendardRegular13)
            .foregroundStyle(Color.idPwdBlack)
        
        Spacer().frame(height: 1.98)
        
        Divider()
            .frame(width: 402)
        
        Spacer().frame(height: 49.04)
        
        Text("비밀번호")
            .font(.PretendardRegular13)
            .foregroundStyle(Color.idPwdBlack)
        
        Spacer().frame(height: 1.98)
        
        Divider()
            .frame(width: 402)
    }
    
}

//로그인 부분
private var loginGroup: some View {
    VStack(alignment: .center) {
        Button(action: {}, label: {
            Text("로그인하기")
                .font(.PretendardMedium16)
                .frame(width: 402, height: 46)
                .background(Color.loginButtonGreen)
                .foregroundColor(.white)
                .cornerRadius(20)
                
        })
        
        Spacer().frame(height: 104)

        Text("이메일로 회원가입하기")
            .font(.PretendardRegular12)
            .foregroundColor(Color.emailLoginGray)
            .underline()
            .multilineTextAlignment(.center) //필요한가?
        
        Spacer().frame(height: 19)
        
        Image("KakaoLogin")
            .resizable() // 필요한가?
            .frame(width: 306, height: 45)
            .aspectRatio(contentMode: .fit)
        
        Spacer().frame(height: 19)
        
        Image("AppleLogin")
            .resizable()
            .frame(width: 306, height: 45)
            .aspectRatio(contentMode: .fit)
        
    }
}







#Preview {
    LoginView()
}
