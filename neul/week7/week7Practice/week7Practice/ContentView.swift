//
//  ContentView.swift
//  week7Practice
//
//  Created by tokkislove on 5/19/25.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        VStack(spacing: 15) {
            ForEach(ButtonInfoList.buttonList, id: \.id) { button in
                Button(action: {
                    button.action()
                }, label: {
                    Text(button.title)
                })
            }
        }
        .padding()
    }
}

struct ButtonInfo: Identifiable {
    var id: UUID = .init()
    var title: String
    var action: () -> Void
}

final class ButtonInfoList {
    
    static let serviceManager: ContentsViewModel = .init()
    
    static let buttonList: [ButtonInfo] = [
        .init(title: "GET", action: {
            
            serviceManager.getUserData(name: "서현")
        }),
        .init(title: "POST", action: {
            serviceManager.createUser(.init(name: "서현", age: 25, address: "서울시 서대문구", height: 154))
        }),
        .init(title: "PATCH", action: {
            serviceManager.updateUserPatch(.init(name: nil, age: 15, address: nil, height: nil))
        }),
        .init(title: "PUT", action: {
            serviceManager.updateUserPut(.init(name: "tokkislove", age: 23, address: "서울시", height: 154))
        }),
        .init(title: "DELETE", action: {
            serviceManager.deleteUser(name: "서현")
        }),
    ]
}

#Preview {
    ContentView()
}

