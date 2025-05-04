//
//  ReceiptsModel.swift
//  Practice4
//
//  Created by 신민정 on 4/3/25.
//
//영수증에서 추출해서 얻어올 데이터 정의

import Foundation
import SwiftData

@Model
class ReceiptsModel {
    @Attribute(.unique) var id: UUID // 고유 식별자 ( 데이터베이스의 기본키처럼 동작합니다 )
    
    var orderer: String // 주문자
    var store: String // 장소
    var menuItems: [String] // 마신 음료
    var totalAmount: Int         // 결제 금액
    var orderNumber: String      // 주문번호
    var createdAt: Date          // 저장된 시점
    
    init(
            orderer: String, // 주문 닉네임
            store: String, //매장정보
            menuItems: [String],//메뉴리스트
            totalAmount: Int, // 결제금액
            orderNumber: String, //주문번호
            createdAt: Date = Date() //생성일
        ) {
            self.id = UUID()
            self.orderer = orderer
            self.store = store
            self.menuItems = menuItems
            self.totalAmount = totalAmount
            self.orderNumber = orderNumber
            self.createdAt = createdAt
            //이건 클래스 객체 만들때 넣어줄겡 이뜻 
        }
}
