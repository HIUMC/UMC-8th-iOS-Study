
import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack(alignment: .center) {
            Rectangle()
                .fill(Color.starbucksGreen)
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
            
            Image(.starbucksPng)
        }
    }
}

    
    
#Preview {
    SplashView()
}
