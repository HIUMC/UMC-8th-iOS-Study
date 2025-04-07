import SwiftUI

struct CircleImageCard: View {
    let menu: CoffeeItem
    @EnvironmentObject private var router: NavigationRouter
    @ObservedObject var detailViewModel: MenuDetailViewModel

    var body: some View {
        VStack {
            Image(menu.imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 130, height: 130)
                .clipShape(Circle())

            Spacer().frame(height: 10)

            Text(menu.name)
                .font(.customPretend(.medium, size: 14))
                .foregroundStyle(.black)
        }
        .frame(width: 130, height: 160)
        .onTapGesture {
            if let matchedMenu = detailViewModel.menuDetails.first(where: { $0.name == menu.name }) {
                print("✅ Found menu id: \(matchedMenu.id)")
                router.push(.cafeMenu(matchedMenu)) // <-- 요렇게
            } else {
                print("❌ 메뉴 이름 매칭 실패: \(menu.name)")
            }
        }
    }
}
