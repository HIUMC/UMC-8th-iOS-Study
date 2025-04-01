//
//  ScreenSizeView.swift
//  week2Practice
//
//  Created by tokkislove on 3/28/25.
//

import SwiftUI

struct ScreenSizeView: View {
    
    var screenSize: CGRect {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .zero
        }
        return windowScene.screen.bounds
    }
    
    var body: some View {
        VStack {
            Text("screen width: \(screenSize.width)")
            Text("screen height: \(screenSize.height)")
        }
        
    }
}

#Preview {
    ScreenSizeView()
}
