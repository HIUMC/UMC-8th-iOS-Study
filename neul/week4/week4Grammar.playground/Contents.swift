import UIKit

/*func checkTemperature(temp: Int) {
    if temp > 35 {
        print("덥다")
    } else if temp > 10 {
        print("적당하다")
    } else {
        print("춥다")
    }
            
}

checkTemperature(temp: 15)*/

/*func currentDate() -> String {
        let today = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let strDate = dateFormatter.string(from: today)
        return "오늘 날짜: \(strDate)"
}

print(currentDate())*/

/*let addValue = {
    var sum = 0
    for i in 1...$0 {
        sum += i
    }
    return sum
}

let addValue2 = { (number: Int) -> Int in
    (1...number).reduce(0, +)
}

let addValue3: (Int) -> Int = { (1...$0).reduce(0, +) }

print(addValue(11))*/

/*class BankAccount {
    let accountNumber: String
    private(set) var balance: Double
    
    init(accountNumber: String, initialBalance: Double) {
        self.accountNumber = accountNumber
        self.balance = (initialBalance > 0) ? initialBalance : 0
    }
    
    func deposit(amount: Double) {
        balance += amount
        print("입금된 금액: \(amount)")
        print("현재 잔액: \(balance)")
    }
    
    func withdraw(amount: Double) {
        if amount > balance {
            print("Insufficient funds")
        } else {
            balance -= amount
            print("출금된 금액: \(amount)")
            print("현재 잔액: \(balance)")
        }
    }
}

/* 코드 시나리오, 위 클래스 구현 후 실행 시켜주세요! */

let account = BankAccount(accountNumber: "123-456", initialBalance: 100.0)

account.deposit(amount: 50.0) // 출력: "Deposited 50.0. Current balance: 150.0"
account.withdraw(amount: 30.0) // 출력: "Withdrew 30.0. Current balance: 120.0"
account.withdraw(amount: 200.0) // 출력: "Insufficient funds. Current balance: 120.0"
*/


struct Car {
    let make: String
    let model: String
    var year: Int
    var mileage: Double
    var isRunning: Bool
    
    
    mutating func start() {
        if isRunning {
            print("차 이미 시동 중")
        } else {
            isRunning = true
            print("차 시동 걸림")
        }
    }
    
    mutating func stop() {
        if !isRunning {
            print("차 이미 꺼짐")
        } else {
            isRunning = false
            print("차 시동 꺼짐")
        }
    }
    
    mutating func drive(distance: Double) {
        if isRunning {
            mileage += distance
            print("이동거리 \(distance) km. 현재 mileage:  \(mileage) km")
        } else {
            print("이동 불가능. 차 시동 꺼짐.")
        }
    }
}

/* 코드 시나리오, 위 클래스 구현 후 실행 시켜주세요! */

var myCar = Car(make: "한국", model: "KIA", year: 2024, mileage: 15000.0, isRunning: false)

myCar.start() // 출력: "차 시동 걸림."
myCar.drive(distance: 100) // 출력: "이동거리 100 km. 현재 mileage: 15100 km"
myCar.stop() // 출력: "차 시동 꺼짐."
myCar.drive(distance: 50) // 출력: "이동 불가능. 차 시동 꺼짐."
myCar.start() // 출력: "Car started."
myCar.start() // 출력: "차 이미 시동 중."
