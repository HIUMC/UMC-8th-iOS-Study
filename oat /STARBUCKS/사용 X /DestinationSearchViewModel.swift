//
//  DestinationSearchViewModel.swift
//  STARBUCKS
//
//  Created by 신민정 on 5/19/25.
//
//도착지 검색함수 

import Foundation
import Foundation

class DestinationSearchViewModel: ObservableObject {
    @Published var query: String = ""
    @Published var results: [Store] = []

    // 검색 함수
    func search(in stores: [Store]) {
        let trimmedQuery = query.trimmingCharacters(in: .whitespaces)
        guard !trimmedQuery.isEmpty else {
            results = []
            return
        }

        // 필터링: placeName 우선, 그다음 addressName
        results = stores
            .filter {
                $0.name.contains(trimmedQuery) || $0.address.contains(trimmedQuery)
            }
            .sorted(by: {
                if $0.name == trimmedQuery { return true }
                if $1.name == trimmedQuery { return false }
                return false
            })
    }
}
