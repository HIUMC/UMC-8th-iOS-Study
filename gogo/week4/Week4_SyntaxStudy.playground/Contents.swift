////////class Rectangle {
////////    var width: Double
////////    var height: Double
////////    
////////    init(width: Double, height: Double) {
////////            self.width = width
////////            self.height = height
////////        }
////////}
////////
////////extension Rectangle {
////////    var area: Double {
////////            return width * height
////////        } //클로저
////////        
////////        func description() -> String {
////////            return "width: \(width), height: \(height)"
////////        } //속성(메소드 함수)
////////}
////////
////////let rect = Rectangle(width: 10, height: 10)
////////print("Area: \(rect.area)") // 직접 확인 해주시기 바랍니다.
////////print(rect.description()) // 직접 확인 해주시기 바랍니다.
//////
//////
//////
//////class Customer {
//////    let name: String
//////    var card: CreditCard?
//////    
//////    init(name: String) {
//////        self.name = name
//////    }
//////    
//////    deinit {
//////        print("\(name) is being deinitialized")
//////    }
//////}
//////
//////class CreditCard {
//////    let number: Int
//////    unowned var customer: Customer // 미소유 참조 사용
//////    
//////    init(number: Int, customer: Customer) {
//////        self.number = number
//////        self.customer = customer
//////    }
//////    
//////    deinit {
//////        print("CreditCard #\(number) is being deinitialized")
//////    }
//////}
//////
//////var john: Customer? = Customer(name: "John")
//////john!.card = CreditCard(number: 1234, customer: john!)
//////
//////john = nil // Customer와 CreditCard 인스턴스 모두 해제됨
////
////
////import SwiftUI
////
////class BankAccount {
////    var accountNumber : String
////    private(set) var balance : Double
////    //init 초기화 메소드로 전달 받는 인자가 꼭 클래스의 프로퍼티(기본 속성 변수)일 필요는 없다.
////    
////    init(accountNumber : String, initialBalance : Double) {
////        self.accountNumber = accountNumber
////        if initialBalance >= 0 {
////            self.balance = initialBalance
////        }
////        else {self.balance = 0}
////}
////    
////    func deposit(amount : Double) {
////        self.balance += amount
////        print("Deposited \(amount). Current Balance: \(balance)")
////    }
////    func withdraw(amount : Double) {
////        if amount > balance {
////            print("Insufficient funds.Current Balance: \(balance)")
////            
////        }
////        else {
////            self.balance -= amount
////            print("Withdrawn \(amount). Current Balance: \(balance)")
////        }
////    }
////}
////
////
/////* 코드 시나리오, 위 클래스 구현 후 실행 시켜주세요! */
////
////let account = BankAccount(accountNumber: "123-456", initialBalance: 100.0)
////
////account.deposit(amount: 50.0) // 출력: "Deposited 50.0. Current balance: 150.0"
////account.withdraw(amount: 30.0) // 출력: "Withdrew 30.0. Current balance: 120.0"
////account.withdraw(amount: 200.0) // 출력: "Insufficient funds. Current balance: 120.0"
////
////
////
//
//
//
//
//
//import SwiftUI
//
//struct Car {
//    var make: String
//    var model: String
//    var year: Int
//    var mileage: Double
//    var isRunning: Bool
//    
//    init(make: String, model: String, year: Int, mileage: Double, isRunning: Bool) {
//        self.make = make
//        self.model = model
//        self.year = year
//        self.mileage = mileage
//        self.isRunning = isRunning
//    }
//    
//    
//    mutating func start() {
//        if isRunning {
//            print("차 이미 시동 중.")
//        } else {
//            isRunning = true
//            print("차 시동 걸림.")
//        }
//}
//    
//    mutating func stop() {
//        if isRunning{
//            isRunning = false
//            print("차 시동 꺼짐.")
//        } else {
//            print("차 이미 꺼짐.")
//        }
//    
//    }
//    
//    mutating func drive(distance : Double) {
//        if !isRunning {
//            print("이동 불가능. 차 시동 꺼짐.")
//        } else {
//            mileage += distance
//            print("이동거리 \(distance) km. 현재 mileage: \(mileage) km")
//        }
//   }
//    
//}
//
///* 코드 시나리오, 위 클래스 구현 후 실행 시켜주세요! */
//
//var myCar = Car(make: "한국", model: "KIA", year: 2024, mileage: 15000.0, isRunning: false)
//
//myCar.start() // 출력: "차 시동 걸림."
//myCar.drive(distance: 100) // 출력: "이동거리 100 km. 현재 mileage: 15100 km"
//myCar.stop() // 출력: "차 시동 꺼짐."
//myCar.drive(distance: 50) // 출력: "이동 불가능. 차 시동 꺼짐."
//myCar.start() // 출력: "Car started."
//myCar.start() // 출력: "차 이미 시동 중."



protocol Challenger {
        func doWorkbook()
}

class PartLeader {
    let challenger: Challenger
    
    init(challenger: Challenger) {
        self.challenger = challenger
    }
    
    func deployment() {
            print("파트장은 워크북 배포 완료!")
        challenger.doWorkbook()
    }
}

class zimging: Challenger {
    func doWorkbook() {
        print("챌린저는 워크북 하는 중!")
    }
}

let challenger: Challenger = zimging()
let partLeader = PartLeader(challenger: challenger)

partLeader.deployment()
