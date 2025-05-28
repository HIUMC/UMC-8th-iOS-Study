//
//  DestSearchViewModel.swift
//  StarbuckApp
//
//  Created by 박병선 on 5/27/25.
//
import Foundation
import SwiftUI

class DestinationSearchViewModel: ObservableObject {
    @Published var allStores: [StoreFeature] = []
    @Published var filteredStores: [StoreFeature] = []
    @Published var destinationText: String = ""
    @Published var selectedDestination: StoreFeature? = nil
    @Published var showResult: Bool = false

    init() {
        loadStores()
    }

    func loadStores() {
        guard let url = Bundle.main.url(forResource: "store_list", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let decoded = try? JSONDecoder().decode(StarbucksStoreModel.self, from: data) else {
            print(" 매장 데이터 불러오기 실패")
            return
        }

        self.allStores = decoded.features
    }

    func search() {
        let keyword = destinationText.trimmingCharacters(in: .whitespaces)
        guard !keyword.isEmpty else {
            filteredStores = []
            showResult = false
            return
        }

        let matchByName = allStores.filter { $0.properties.storeName.localizedCaseInsensitiveContains(keyword) }
        let matchByAddress = allStores.filter {
            !$0.properties.storeName.localizedCaseInsensitiveContains(keyword) &&
            $0.properties.address.localizedCaseInsensitiveContains(keyword)
        }

        self.filteredStores = matchByName + matchByAddress
        self.showResult = true
    }

    func select(_ store: StoreFeature) {
        self.selectedDestination = store
        self.destinationText = store.properties.storeName
        self.showResult = false
    }
}
