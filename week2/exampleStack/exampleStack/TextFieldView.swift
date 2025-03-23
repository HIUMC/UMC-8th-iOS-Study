
import SwiftUI

struct TextFieldView: View {
    @State private var text: String = ""

    var body: some View {
        VStack {
            Text("텍스트 내용: \(text)")
                .font(.largeTitle)

            TextField("아무 값을 입력해보세요!", text: $text)
                .frame(width: 350)
        }
    }
}

#Preview {
    TextFieldView()
}
