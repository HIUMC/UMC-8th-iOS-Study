import SwiftUI

struct BottomTapView: View {
    var body: some View {
        HStack(spacing: 44) {
            
            TabView {
                Tab("Home", systemImage: "house.fill") {
                    
                }
                
                Tab("Pay", image: "TabIcon2") {
                    
                }
                
                Tab("Order", image: "TabIcon3") {
                    
                }
                
                Tab("Shop", image: "TabIcon4") {
                    
                }
                
                Tab("Other", image: "TabIcon5") {
                    
                }
            }
            .tint(Color.mainGreen)
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 22)
    }
}

#Preview {
    BottomTapView()
}
