//
//  ContentViewModel.swift
//  week8Practice
//
//  Created by tokkislove on 6/17/25.
//

import Combine

class ContentViewModel: ObservableObject {
    @Published var name: String = "tokki"
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        $name
            .sink { newName in
                print("새 이름: \(newName)")
            }
            .store(in: &cancellables)
    }
}
