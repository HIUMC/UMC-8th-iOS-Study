
import SwiftUI

struct StackView: View {
    var body: some View {
        VStack(alignment: .center, spacing: 30) {
            Text("1번 요소")
                .font(.title)
            //Spacer().frame(width: 10)
                .padding(10)
            Text("2번 요소")
                .font(.headline)
            Text("3번 요소")
                .font(.subheadline)
        }
        .padding() //뷰의 여백 설정
        
        HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 20) {
            Image(systemName: "star.fill")
            Text("즐겨찾기")
                .font(.headline)
        }
        .padding()
    }
    
}

#Preview {
    StackView()
}
