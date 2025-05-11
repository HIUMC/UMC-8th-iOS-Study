//
//  ReceiptsModel.swift
//  Week4_Practice
//
//  Created by 고석현 on 4/22/25.
//



import Foundation  // UUID, Date 등 기본 타입과 기능을 사용하기 위해 필요한 모듈
import SwiftData   // SwiftData 프레임워크: SwiftUI와 통합된 데이터 모델링 시스템 사용 가능

@Model  // ✅ SwiftData에서 이 클래스를 '모델 객체'로 인식하게 만듬 (CoreData의 NSManagedObject와 유사)
        // 이 어노테이션을 붙이면 내부적으로 저장/불러오기 등을 자동으로 지원하게 된다
class ReceiptsModel {
    
    @Attribute(.unique) var id: UUID
    // ✅ UUID는 고유 식별자로 사용 (데이터베이스의 primary key 역할)
    // ✅ .unique 옵션은 이 속성이 **고유해야 한다**는 것을 의미
    //    → 즉, 같은 UUID를 가진 두 객체는 저장될 수 없다 (중복  )

    var orderer: String
    // ✅ 주문자 이름 (예: "홍길동")
    
    var store: String
    // ✅ 주문한 매장 이름 (예: "스타벅스 강남점")
    
    var menuItems: [String]
    // ✅ 주문한 메뉴들 (예: ["아메리카노", "카페라떼"])
    // ✅ 문자열 배열로 구성됨

    var totalAmount: Int
    // ✅ 총 결제 금액 (예: 8900)
    
    var orderNumber: String
    // ✅ 주문번호 (예: "ORD12345678") - 문자열로 관리
    
    var createdAt: Date
    // ✅ 이 객체가 생성(저장)된 시간
    // ✅ Date 타입은 시간 정보를 갖는 객체로, 현재 시간 또는 특정 시점을 나타냄
    // ✅ 디폴트로 현재 시간 (`Date()`)이 들어오도록 설정함 (아래 init에서 설명)

    
    // ✅ 생성자(Initializer): 새로운 영수증 데이터를 만들 때 사용됨
    init(
        orderer: String,            // 주문자 이름을 매개변수로 받음
        store: String,              // 매장 이름
        menuItems: [String],        // 주문한 메뉴 배열
        totalAmount: Int,           // 결제 금액
        orderNumber: String,        // 주문번호
        createdAt: Date = Date()    // ✅ 생성 시간을 매개변수로 받되, 전달하지 않으면 기본값으로 현재 시간 사용
    ) {
        self.id = UUID()            // ✅ 매 객체마다 고유한 UUID를 자동 생성 (직접 넣을 필요 없음)
        self.orderer = orderer
        self.store = store
        self.menuItems = menuItems
        self.totalAmount = totalAmount
        self.orderNumber = orderNumber
        self.createdAt = createdAt  // 위 매개변수로 받은 createdAt을 그대로 저장
    }
}
