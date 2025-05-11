//
//  ContentView.swift
//  week6Practice
//
//  Created by tokkislove on 5/8/25.
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
    
    static let serviceManager: ServiceManagerAA = .init()
    
    
    static let buttonList: [ButtonInfo] = [
        .init(title: "GET", action: {
            Task {
                await serviceManager.getUser(name: "토토")
            }
        }),
        .init(title: "POST", action: {
            Task {
                await serviceManager.postUser(user: .init(name: "김서현", age: 25, address: "서울시 서대문구", height: 155))
            }
        }),
        .init(title: "PATCH", action: {
            Task {
                await serviceManager.patchUser(name: "tokkislove")
            }
        }),
        .init(title: "PUT", action: {
            Task {
                await serviceManager.putUser(user: .init(name: "토토", age: 20, address: "서울시 홍대입구역", height: 200))
            }
        }),
        .init(title: "DELETE", action: {
            Task {
                await serviceManager.deleteUser(name: "토토")
            }
        }),
    ]
}

#Preview {
    ContentView()
}

