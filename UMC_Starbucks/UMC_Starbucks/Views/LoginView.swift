
import SwiftUI

struct LoginView: View {
    var body: some View {
        mainTitleGroup
        idPwdGroup
        loginGroup
    }
}

//상단 title
private var mainTitleGroup: some View {
    VStack(alignment: .leading) {
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
        
        Spacer().frame(height: 49.04)
        
        Text("비밀번호")
            .font(.PretendardRegular13)
            .foregroundStyle(Color.idPwdBlack)
        
        Spacer().frame(height: 1.98)
        
    Divider()
    }
    
}

private var loginGroup: some View {
    VStack(alignment: .center) {
        Text("로그인하기")
            .font(.PretendardMedium16)
            .foregroundStyle(Color.white)
            .padding() //해야 하나?
            .overlay(content: {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.loginButtonGreen)
                    .frame(width: 402, height: 46)
            })
    }
}







#Preview {
    LoginView()
}
