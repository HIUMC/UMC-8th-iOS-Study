
/* 상위 뷰 */

import SwiftUI

struct CounterView: View {
    @State private var isClicked: Bool = false

    var body: some View {
        VStack {
            Text("현재 State 변수 값: \(isClicked.description)")
            
            CustomButton(isClicked: $isClicked)
        }
    }
}

#Preview {
    CounterView()
}

