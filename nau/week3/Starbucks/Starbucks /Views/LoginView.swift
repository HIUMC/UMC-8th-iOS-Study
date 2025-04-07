//
//  LoginView.swift
//  Starbucks
//
//  Created by nau on 3/18/25.
//

import SwiftUI
import Foundation

struct LoginView: View {
    @Environment(NavigationRouter.self) private var router
    
    //@State private var router = NavigationRouter() // 라우터 인스턴스 생성
   
    @Bindable var viewModel : LoginViewModel = .init()
    
    @AppStorage("nickname") var nickname = ""
    @AppStorage("email") var email = ""
    @AppStorage("pwd") var pwd = ""
    
    @State private var inputEmail = ""
    @State private var inputPwd = ""

    enum Field {
        case id
        case pwd
    }
    
    @FocusState private var isFocused: Field?
    
    var body: some View {
        //GeometryReader를 이용해 화면 뷰 width값을 받아온다.
        //피그마를 보면 수평edge에서 19씩 떨어져있으니 요소들의 width를 geometry.size.width - 38로 잡고 가운데 정렬해주면 된다.
        //가운데 정렬은 postion(x,y)를 이용했다.
        GeometryReader { geometry in
            VStack(spacing: geometry.size.height/9.5) {
                topView
                middleView
                bottomView
            }.frame(width: UIScreen.screenSize.width - 38)
                .position(x: geometry.size.width/2, y: geometry.size.height/2)
        }
    }
    
    
    private var topView : some View {
        VStack(alignment: .leading) {
            Image(.starbucksLogo)
                .resizable()
                .frame(maxWidth: 95, maxHeight: 95)
            Spacer().frame(maxHeight: 28)
            Text("안녕하세요.\n스타벅스입니다.")
                .font(.mainTextExtraBold24)
                .kerning(3)
            Spacer().frame(maxHeight: 19)
            Text("회원 서비스 이용을 위해 로그인 해주세요")
                .font(.mainTextMedium16)
                .foregroundStyle(Color(.gray01))
                .frame(width: UIScreen.screenSize.width - 38, alignment: .leading)
        }
    }
    
    private var middleView : some View {
        VStack(alignment: .leading, content: {
            Text("아이디")
                .font(.mainTextRegular13)
                .foregroundStyle(Color(.black01))
            TextField("아이디를 입력해주세요", text: $inputEmail)
                .focused($isFocused, equals: .id) //포커스 연결
            Divider()
                .frame(height: 1)
                .background(isFocused == .id ? Color(.green01) : Color(.gray00))
            Spacer().frame(maxHeight: 47)
            Text("비밀번호")
                .font(.mainTextRegular13)
                .foregroundStyle(Color(.black01))
            TextField("비밀번호를 입력해주세요", text: $inputPwd)
                .focused($isFocused, equals: .pwd)
            Divider()
                .frame(height: 1)
                .background(isFocused == .pwd ? Color(.green01) : Color(.gray00))
            Spacer().frame(maxHeight: 47)
            Button(action: {
                if inputEmail == email && inputPwd == pwd {
                    inputEmail = ""
                    inputPwd = ""
                    router.push(.tab)
                }
            }, label: {
                Text("로그인하기")
            }).buttonStyle(mainBtnStyle())
        })
    }
    
    private var bottomView : some View {
        VStack(spacing: 19) {
            Button(action: {
                router.push(.signup)
            }, label: {
                Text("이메일로 회원가입하기")
                    .font(.mainTextRegular12)
                    .underline()
                    .baselineOffset(2)//글자와 밑줄 간격 조정
                    .foregroundStyle(Color(.gray04))
            })
            
            Button(action: {
                print("kakaoLogin")
            }, label: {
                Image(.kakaoLogin)
                    .resizable()
                    .scaledToFit()
                    .frame(width: UIScreen.screenSize.width - 138)
            })
            Button(action: {
                print("appleLogin")
            }, label: {
                Image(.appleLogin)
                    .resizable()
                    .scaledToFit()
                    .frame(width: UIScreen.screenSize.width - 138)
            })
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

