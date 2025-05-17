/* 1. 함수 */
func calculateTotalPrice(price: Int, tip: Int) {
    print("최종 결제 금액: \(price + tip)원")
}
calculateTotalPrice(price: 10000, tip: 2000)

func checkTemperature(temperature: Int) {
    if temperature < 0 {
        print("춥다")
    } else if temperature >= 0 && temperature < 20 {
        print("적당하다")
    } else {
        print("덥다")
    }
}
checkTemperature(temperature: 17)

func printTravelBudget(city: String, days: Int, budget: Int) {
    print("\(city)에서의 총 여행 예산은 \(days * budget)원 입니다.")
}
printTravelBudget(city: "캐나다", days: 10, budget: 100000)

import Foundation
func getCurrentDate() {
    let date = Date()
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    let dateString = dateFormatter.string(from: date)
    print(dateString)
}
getCurrentDate()


/* 2. 클로저 */
let addValue = {(a: Int) ->  Int in
    var sum = 0
    for i in 1...a {
        sum += i
    }
    return sum
}
print(addValue(5))

let addValueLight = {
    var sum = 0
    for i in 1...$0 {
        sum += i
    }
    return sum
}
print(addValueLight(5))


/* 3. 클래스 */
class Vehicle {
var speed = 0

func description() -> String {
    return "\(speed) km/h"
}
}

class Car: Vehicle {
var gear = 1

func changeGear(to gear: Int) {
    self.gear = gear
}

// 부모 클래스의 메서드를 재정의하여 추가적인 정보를 제공
override func description() -> String {
    return super.description() + " 현재 기어 :  \(gear)"
}
}

class Rectangle {
    var width: Double
    var height: Double
    
    init(width: Double, height: Double) {
        self.width = width
        self.height = height
    }
}

extension Rectangle {
    var area: Double {
        return width * height
    }
    
    func description() -> String {
        return "width: \(width), height: \(height)"
    }
}

let rect = Rectangle(width: 10, height: 10)
print("Area: \(rect.area)")
print(rect.description())

let car = Car()
car.speed = 120
car.changeGear(to: 3)
print(car.description())

class BankAccount {
    let accountNumber: String
    private var balance: Double = 0.0
    
    init(accountNumber: String, initialBalance: Double) {
        self.accountNumber = accountNumber
        if initialBalance < 0 {
            self.balance = 0.0
        } else {
            self.balance = initialBalance
        }
    }
    
    func deposit(amount: Double) {
        balance += amount
        print("Deposited \(amount). Current balance: \(balance)")
    }
    
    func withdraw(amount: Double) {
        if amount > balance {
            print("Insufficient funds. Current balance: \(balance)")
        } else {
            balance -= amount
            print("Withdraw \(amount). Current balance: \(balance)")
        }
    }
}


let account = BankAccount(accountNumber: "123-456", initialBalance: 100.0)

account.deposit(amount: 50.0) // 출력: "Deposited 50.0. Current balance: 150.0"
account.withdraw(amount: 30.0) // 출력: "Withdrew 30.0. Current balance: 120.0"
account.withdraw(amount: 200.0) // 출력: "Insufficient funds. Current balance: 120.0"


/* 4. 구조체 */
struct Car {
    var make: String
    var model: String
    var year: Int
    var mileage: Double
    var isRunning: Bool = false
    
    init(make: String, model: String, year: Int, mileage: Double, isRunning: Bool) {
        self.make = make
        self.model = model
        self.year = year
        self.mileage = mileage
        self.isRunning = isRunning
    }
    
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
            print("이동거리 \(distance) km. 현재 mileage: \(mileage) km" )
        } else {
            print("이동 불가능. 차 시동 꺼짐")
        }
    }
}

var myCar = Car(make: "한국", model: "KIA", year: 2024, mileage: 15000.0, isRunning: false)

myCar.start() // 출력: "차 시동 걸림."
myCar.drive(distance: 100) // 출력: "이동거리 100 km. 현재 mileage: 15100 km"
myCar.stop() // 출력: "차 시동 꺼짐."
myCar.drive(distance: 50) // 출력: "이동 불가능. 차 시동 꺼짐."
myCar.start() // 출력: "Car started."
myCar.start() // 출력: "차 이미 시동 중."
