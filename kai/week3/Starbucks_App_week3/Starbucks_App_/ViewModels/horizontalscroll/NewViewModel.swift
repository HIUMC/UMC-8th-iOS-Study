//
//  NewViewModel.swift
//  Starbucks_App_
//
//  Created by 김지우 on 4/3/25.
//

import Foundation
import Observation

@Observable
class NewViewModel {
    var items: [NewModel] = [
        NewModel(imageName:"zerodisposable", title:"25년 3월 일회용컵 없는 날 캠페..", description:"매월 10일은 일회용컵 없는 날! 스타벅스 에모매장 \n에서 개인컵 및 다회용 컵을 이용하세요." ),
        NewModel(imageName:"partnership", title:"스타벅스 ooo점을 찾습니다", description:"스타벅스 커뮤니티 스토어 파트너를 웅영할 기관\n을 공모합니다." ),
        NewModel(imageName:"springreserve", title:"2월 8일, 리저브 스프링 신규 커...", description:"산뜻하고 달콤한 풍미가 가득한 리저브를 맛보세\n요." )
        
    ]
}
