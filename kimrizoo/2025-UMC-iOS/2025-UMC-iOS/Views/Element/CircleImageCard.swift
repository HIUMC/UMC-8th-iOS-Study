import SwiftUI

struct CircleImageCard: View {
    let coffee: CoffeeItem
    @StateObject private var viewModel = MenuDetailViewModel()
    @State private var isActive = false  // 네비게이션 활성화 상태 관리

    var body: some View {
        VStack {
            Image(coffee.imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 130, height: 130)
                .clipShape(Circle())

            Spacer().frame(height: 10)

            Text(coffee.name)
                .font(.customPretend(.medium, size: 14))
                .foregroundStyle(.black)
        }
        .frame(width: 130, height: 160)
        .onTapGesture {
            viewModel.selectMenu(name: coffee.name)
            isActive = true
        }
        .background(
            NavigationLink(destination: MenuDetailView(menu: viewModel.selectedMenu),
                           isActive: $isActive) {
                EmptyView()
            }
            .hidden()
        )
    }
}
