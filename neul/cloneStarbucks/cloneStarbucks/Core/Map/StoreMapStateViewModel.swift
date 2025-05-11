//
//  StoreMapStateViewModel.swift
//  cloneStarbucks
//
//  Created by tokkislove on 5/3/25.
//

import Foundation

final class StoreMapStateViewModel: ObservableObject {
    @Published var shouldMoveToUserLocation: Bool = false
}
