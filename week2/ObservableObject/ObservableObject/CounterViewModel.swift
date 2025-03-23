/*
import SwiftUI

class CounterViewModel: ObservableObject {
    @Published var count: Int = 0 // @Published 속성이 변경되면 이를 구독하는 모든 뷰가 자동 업뎃
}
*/

/* viewModel 작성 */

import SwiftUI

class CounterViewModel: ObservableObject {
    @Published var count: Int = 0
}
