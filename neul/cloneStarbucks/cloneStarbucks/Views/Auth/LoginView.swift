//
//  LoginView.swift
//  cloneStarbucks
//
//  Created by tokkislove on 3/22/25.
//

import SwiftUI
import WebKit

struct LoginView: View {
    @ObservedObject var viewModel: LoginViewModel = .init()
    @FocusState private var isFocused: Bool
    @EnvironmentObject var router: NavigationRouter
    @Environment(\.openURL) var openURL
    let networkManager: NetworkManager = .init()
    @State var isWeb:Bool = false
    @State private var url: URL?
    @State private var redirectedURL: URL? = nil
    
    var body: some View {
        VStack {
            topView
                .padding(.top, 100)
            Spacer()
            middleView
                .frame(height: 180)
            Spacer()
            bottomView
                .frame(height: 144)
                .padding(.bottom, 60)
        }
        .sheet(isPresented: $isWeb, content: {
            if let url = url {
                WebView(url: url) { redirectedURL in
                    Task {
                        await networkManager.handleRedirect(url: redirectedURL)
                    }
                    
                    isWeb = false
                }
            } else {
                Text("wrong url")
            }
            
        })
        .toolbar(.hidden, for: .navigationBar)
        .onChange(of: viewModel.isLoggedIn) { _, newValue in
            if newValue {
                router.push(.ad)
            }
        }
    }
    
    private var topView: some View {
        HStack {
            VStack(alignment: .leading) {
                Image("logo")
                    .resizable()
                    .frame(width: 97, height: 95)
                Spacer().frame(height: 28)
                Text("안녕하세요. \n스타벅스입니다.")
                    .foregroundStyle(.black)
                    .font(.MainTextExtraBold24)
                    .kerning(2)
                    .padding(.bottom, 10)
                Text("회원 서비스 이용을 위해 로그인 해주세요")
                    .foregroundStyle(.gray01)
                    .font(.MainTextMedium16)
                    .kerning(-1)
                    
            }
            .padding(.leading, 20)
            Spacer()
        }
        .onAppear {
            if let font = UIFont(name: "Pretendard-Regular", size: 18) {
                print("✅ 폰트 로드 성공: \(font)")
            } else {
                print("❌ 폰트 로드 실패 — 이름 또는 설정 문제")
            }
        }
        
    }

    private var middleView: some View {
        
        let fields: [(label: String, binding: Binding<String>)] = [("아이디", $viewModel.id), ("비밀번호", $viewModel.pwd)]
        return VStack(alignment: .center, spacing: 47) {
            ForEach(fields, id: \.label) { field in
                CustomUnderlineTextField(placeholder: field.label, text: field.binding)
            }
            Button(action:  {
                if viewModel.keychainLogin() {
                    router.push(.ad)
                } else {
                    print("다시 로그인하세요.")
                }
            }, label: {
                Text("로그인하기")
                    .foregroundStyle(.white)
                    .font(.MainTextMedium16)
                    .frame(maxWidth: .infinity, minHeight: 46)
                    .background(.green01)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
            })
            
        }
        .padding([.horizontal], 20)
    }

    private var bottomView: some View {
            VStack {
                Button(action: {
                    router.push(.signUp)
                }, label: {
                    Text("이메일로 회원가입하기")
                        .font(.MainTextRegular12)
                        .foregroundStyle(.gray04)
                        .underline(true, color: .gray04)
                })
                
                Spacer()
                
                Button(action: {
                    //viewModel.kakaoLogin()
                    Task {
                        if let url = await networkManager.kakaoLogin() {
                            openURL(url)
                            //self.url = url
                            //self.isWeb = true
                        }
                    }
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
                
                Spacer()
                
                Button(action: {
                    print("애플 로그인 클릭됨")
                }) {
                    HStack {
                        Image("appleLogo")
                            .padding(.leading, 20)
                        Spacer()
                    }
                    .overlay(alignment: .center, content: {
                        Text("Apple로 로그인")
                            .foregroundStyle(.white)
                            .font(.MainTextMedium16)
                    })
                    .frame(width: 306, height: 45)
                    .background(.black)
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                }
        }
    }
    
    
}



struct LoginView_Preview: PreviewProvider {
    static var devices = ["iPhone 11", "iPhone 16 Pro Max"]
    
    static var previews: some View {
        ForEach(devices, id: \.self) { device in
            LoginView()
                .environmentObject(NavigationRouter())
                .previewDevice(PreviewDevice(rawValue: device))
                .previewDisplayName(device)
        }
    }
}



struct WebView: UIViewRepresentable {
    let url: URL
    let onRedirect: (URL) -> Void
    
    func makeCoordinator() -> Coordinator {
        Coordinator(onRedirect: onRedirect)
    }

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.load(URLRequest(url: url))
    }

    class Coordinator: NSObject, WKNavigationDelegate {
        let onRedirect: (URL) -> Void
        
        init(onRedirect: @escaping (URL) -> Void) {
            self.onRedirect = onRedirect
        }

        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            if let redirectedURL = navigationAction.request.url {
                // 🔥 여기서 모든 이동 URL이 찍힘
                print("📡 Redirect Attempt to: \(redirectedURL.absoluteString)")
                
                // 여기서 특정 URL 감지해서 처리 가능
                if redirectedURL.absoluteString.contains("code=") {
                    print("로그인 성공, redirect uri 감지됨")
                    onRedirect(redirectedURL)
                    decisionHandler(.cancel) // 웹뷰 내 로딩 막기
                    return
                }
            }

            decisionHandler(.allow)
        }
    }
}
