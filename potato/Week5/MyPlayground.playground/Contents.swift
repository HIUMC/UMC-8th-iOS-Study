/*
 - **주문 추가**
     - `addOrder(_ order: String)` 메서드를 사용하여 `Pizza`, `Burger`, `Pasta`를 순차적으로 주문에 추가합니다.
 - **주문 처리**
     - `processOrder()` 메서드를 사용하여 추가된 주문을 처리합니다. 순서대로 첫 번째 주문 `Pizza`, 두 번째 주문 `Burger`를 처리한 후, 처리된 주문에 대한 메시지가 출력되어야 합니다.
 - **남은 주문 확인**
     - `printAllOrders()` 메서드를 사용하여 현재 남아있는 주문을 확인합니다.
     - 첫 번째 확인에서는 `Pasta`가 남아있어야 하고, 마지막 확인에서는 남은 주문이 없어야 합니다.
 */

actor OrderProcessor {
        private var orders: [String] = []
    
    // 주문 추가 메서드
    func addOrder(_ order: String) {
            orders.append(order)
            print("추가된 주문: \(order)")
    }

    // 주문 처리 메서드
    func processOrder() {
        if orders.isEmpty {
                print("처리할 주문 없음")
        } else {
                let order = orders.removeFirst()
                print("처리된 주문: \(order)")
        }
    }

    // 현재 남아있는 주문 출력 메서드
    func printAllOrder() {
        if orders.isEmpty {
                print("남아 있는 주문 없음")
        } else {
                print("남아 있는 주문: \(orders.joined(separator: ", "))")
        }
    }
}

let orderProcessor = OrderProcessor()

Task {
    await orderProcessor.addOrder("Pizza")
    await orderProcessor.addOrder("Burger")
    await orderProcessor.addOrder("Pasta")
    
    await orderProcessor.processOrder()
    await orderProcessor.processOrder()
    
    await orderProcessor.printAllOrder()
    
    await orderProcessor.processOrder()
    
    await orderProcessor.printAllOrder()
}
