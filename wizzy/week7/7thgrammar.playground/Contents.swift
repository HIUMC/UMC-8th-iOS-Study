import UIKit

class Rectangle {
    var width: Int = 100
    var height: Int = 20
    
    static let unit = "cm" 
    
    var area: Int {
        get {
            return width*height
        }
    }
}

var rec = Rectangle()
print(rec.width)
print(rec.height)

/*
 2. 1번에서 구현한 `Rectangle` 클래스에서 사각형의 면적을 계산하는 `area`라는 연산 프로퍼티를 선언해주세요. 이후 `width` 와 `height` 를 이용해 면적을 계산하고 출력해주세요.
 3. 1, 2번에서 구현한 `Rectangle` 클래스에서 모든 사각형이 사용할 수 있도록 `cm`라는 값을 가진 `unit`을 추가해주세요. 모든 `Rectangle` 인스턴스가 이 값을 공유할 수 있도록 타입 프로퍼티로 선언해주세요.
 */
