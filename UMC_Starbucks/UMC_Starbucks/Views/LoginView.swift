
import SwiftUI

struct LoginView: View {
    var body: some View {
        mainTitleGroup
    }
}

//상단 title
private var mainTitleGroup: some View {
    VStack(alignment: .leading) {
        Text("안녕하세요.")
            .font(.PretendardExtraBold24)
        Text("스타벅스입니다.")
            .font(.PretendardExtraBold24)
        
        Text("회원 서비스 이용을 위해 로그인 해주세요")
            .font(.PretendardMedium16)
            .foregroundStyle(Color.loginGray)
        
        
        
    }
    
}




#Preview {
    LoginView()
}
