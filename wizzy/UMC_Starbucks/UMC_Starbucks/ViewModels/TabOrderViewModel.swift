//
//  TabOrderViewModel.swift
//  UMC_Starbucks
//
//  Created by 이서현 on 5/1/25.
//

import Foundation


class TabOrderViewModel: ObservableObject {
    @Published var currentTab: TabOrderItem = .allMenu
}
