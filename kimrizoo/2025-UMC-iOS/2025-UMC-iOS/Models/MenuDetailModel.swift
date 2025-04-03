import SwiftUI

// 커피 온도 배열
enum CoffeeTemperature: String, CaseIterable {
    case hot = "HOT"
    case iced = "ICED"
    case hotOnly = "HOT ONLY"
    case icedOnly = "ICED ONLY"
}

// 메뉴 상세 모델
struct MenuDetailModel: Identifiable {
    let id = UUID()
    var name: String
    var englishName: String
    var description: String
    var price: Int
    var imageName: String // 피그마 정사각형 이미지 파일명
    var availableTemperatures: [CoffeeTemperature]
}
