
import SwiftUI

struct SwiftUIView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .font(.largeTitle) //폰트 스타일(제목, 본문)
            .foregroundStyle(Color.red) //폰트 색깔
            .underline() // 글자 밑줄
            .strikethrough() // 글자 중간줄
            .lineLimit(nil) // 뭐지이건?
            .kerning(1.5) // 자간?
            .lineSpacing(2.5) // 문단 간격?
            .padding() // ??
            .overlay(content: {
                RoundedRectangle(cornerRadius: 10) //모서리 얼마나 깎을지!
                    .fill(Color.clear) // 도형 채우기 색
                    .stroke(Color.black, style:  .init(lineWidth: 1)) //도형 테두리 색, 두께
            })
            .dynamicTypeSize(.large) // ??



    }
}

#Preview {
    SwiftUIView()
    
/*
 import SwiftUI

 struct SwiftUIView: View {
     var body: some View {
         Text("Hello, World!")
             .font(.largeTitle) /* 이 글귀를 지우시고 해당 수정자의 역할을 주석으로 달아주세요 */
             .foregroundStyle(Color.red) /* 이 글귀를 지우시고 해당 수정자의 역할을 주석으로 달아주세요 */
             .underline() /* 이 글귀를 지우시고 해당 수정자의 역할을 주석으로 달아주세요 */
             .strikethrough(true, color: Color.black) /* 이 글귀를 지우시고 해당 수정자의 역할을 주석으로 달아주세요 */
             .lineLimit(nil) /* 이 글귀를 지우시고 해당 수정자의 역할을 주석으로 달아주세요 */
             .kerning(1.5) /* 이 글귀를 지우시고 해당 수정자의 역할을 주석으로 달아주세요 */
             .lineSpacing(2.5) /* 이 글귀를 지우시고 해당 수정자의 역할을 주석으로 달아주세요 */
             .padding() /* 이 글귀를 지우시고 해당 수정자의 역할을 주석으로 달아주세요 */
             .overlay(content: {
                 RoundedRectangle(cornerRadius: 10)
                     .fill(Color.clear)
                     .stroke(Color.black, style: .init(lineWidth: 1))
             }) /* 이 글귀를 지우시고 해당 수정자의 역할을 주석으로 달아주세요 */
             .dynamicTypeSize(.large) /* 이 글귀를 지우시고 해당 수정자의 역할을 주석으로 달아주세요 */
     }
 }

 #Preview {
     SwiftUIView()
 }

 */
}
