//
//  UserView.swift
//  MVVM Practice
//
//  Created by tokkislove on 3/18/25.
//

import SwiftUI

struct UserView: View {
    
    @StateObject var viewModel: UserViewModel
    
    init() {
        self._viewModel = .init(wrappedValue: .init(userModel: .init(name: "토끼짱", age: 25)))
    }
    
    
    var body: some View {
        
        VStack {
            HStack {
                Button {
                    viewModel.increaseAge()
                } label: {
                    Image(systemName: "arrow.up.square")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundStyle(Color.black)
                }
                
                Button {
                    viewModel.decreaseAge()
                } label: {
                    Image(systemName: "arrow.down.square")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundStyle(Color.black)
                }
            }
            
            Group {
                Text("이름: \(viewModel.userModel.name)")
                Text("나이: \(viewModel.userModel.age)")
            }
            .padding(.top, 20)
        }
        


    }
}

/*#Preview {
    UserView()
}*/

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView()
    }
}
