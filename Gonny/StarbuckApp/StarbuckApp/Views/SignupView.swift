import SwiftUI
import Observation

struct SignupView: View {
    @StateObject private var viewModel = SignupViewModel()
    @FocusState private var focusedField: FocusField?
    @Environment(\.dismiss) private var dismiss
    
    enum FocusField {
        case nickname, email, password
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(spacing: 49){
                //닉네임
                VStack(spacing: 5) {
                    TextField("닉네임", text: $viewModel.nickname)
                        .font(.mainTextRegular18)
                        .foregroundColor(Color("gray02"))
                        .focused($focusedField, equals: .nickname)
                        .textFieldStyle(.plain)
                        .padding(.vertical,8)
                    
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(focusedField == .nickname ? Color("green01") : Color("gray02"))
                        .animation(.easeInOut(duration: 0.2), value: focusedField)
                }
                
                VStack(spacing: 5){
                    TextField("이메일", text: $viewModel.email)
                        .font(.mainTextRegular18)
                        .foregroundColor(Color("gray02"))
                        .focused($focusedField, equals: .email)
                        .textFieldStyle(.plain)
                        .padding(.vertical,8)
                    
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(focusedField == .email ? Color("green01") : Color("gray02"))
                        .animation(.easeInOut(duration: 0.2), value: focusedField)
                }
                
                VStack(spacing:5){
                    TextField("비밀번호", text: $viewModel.password)
                        .font(.mainTextRegular18)
                        .foregroundColor(Color("gray02"))
                        .focused($focusedField, equals: .password)
                        .textFieldStyle(.plain)
                        .padding(.vertical,8)
                    
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(focusedField == .password ? Color("green01") : Color("gray02"))
                        .animation(.easeInOut(duration: 0.2), value: focusedField)
                }
                
            }
            .padding(.top,172)
            
            Spacer()
            Button(action: {
                if viewModel.nickname.count > 0 &&
                    viewModel.email.count > 0 &&
                    viewModel.password.count > 0 {
                    viewModel.SaveUser()
                    dismiss()
                } else {
                    print("입력값이 한 자리 이상이어야 합니다.")
                }
            }) {
                Text("생성하기")
                    .font(.mainTextMedium16)
                    .foregroundColor(Color("white01"))
                    .padding(.vertical, 18.5)
            }
            .frame(maxWidth: .infinity, minHeight: 48)
            .background(Color("green01"))
            .padding(.top, 210)
            .padding(.bottom, 72)
            .clipShape(RoundedRectangle(cornerRadius: 30))
        }
            /*Button(action:
                    { if viewModel.nickname.count > 0 &&viewModel.email.count > 0 && viewModel.password.count > 0 {
                        viewModel.SaveUser()
                        dismiss()
                    })
            }
            else{
                print("입력값이 한 자리 이상이어야 합니다.")
            }
            {
                Text("생성하기")
                    .font(.mainTextMedium16)
                    .foregroundColor(Color("white01"))
                    .padding(.vertical, 18.5)
            }
            //RoundedRectangle(cornerRadius: 40)
            .frame(maxWidth: .infinity, minHeight: 48)
            .background(Color("green01"))
            .padding(.top, 210)
            .padding(.bottom, 72)
            .clipShape(RoundedRectangle(cornerRadius: 30))
            // RoundedRectangle(cornerRadius: 40)
        }*/
        
            .padding(.horizontal,18)
            .navigationTitle("가입하기")
        }
        
    }

#Preview {
 SignupView()
}
