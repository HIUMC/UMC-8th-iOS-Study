import SwiftUI

struct OtherMapView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var selectedTab = "매장 찾기"
    @Namespace private var underline

    var body: some View {
        VStack(spacing: 0) {
            // Safe 영역을 지키는 TopBar
            TopBar(title: "매장 찾기") {
                dismiss()
            }

            // 탭 바
            TabBar(selectedTab: $selectedTab, underline: underline)

            // 컨텐츠 뷰 (SafeArea 무시)
            ZStack {
                if selectedTab == "매장 찾기" {
                    MapSearchView(viewModel: MapViewModel())
                } else {
                    RouteSearchView(mapViewModel: MapViewModel())
                }
            }
        }
        .navigationBarHidden(true)
    }
}

// MARK: - Top Bar

struct TopBar: View {
    let title: String
    let onBack: () -> Void

    var body: some View {
        HStack {
            Button(action: onBack) {
                Image(systemName: "chevron.left")
                    .font(.system(size: 16))
                    .foregroundColor(.black)
            }

            Spacer()

            Text(title)
                .font(.customPretend(.medium, size: 16))
                .foregroundColor(.black)

            Spacer()
        }
        .padding(.horizontal)
        .padding(.bottom, 8)
        .background(Color.white)
    }
}

// MARK: - Tab Bar

struct TabBar: View {
    @Binding var selectedTab: String
    var underline: Namespace.ID

    var body: some View {
        HStack(spacing: 0) {
            TabButton(title: "매장 찾기", selectedTab: $selectedTab, underline: underline)
            TabButton(title: "길찾기", selectedTab: $selectedTab, underline: underline)
        }
        .background(Color.white)
    }
}

// MARK: - Tab Button

struct TabButton: View {
    let title: String
    @Binding var selectedTab: String
    var underline: Namespace.ID

    var isSelected: Bool {
        selectedTab == title
    }

    var body: some View {
        Button(action: {
            selectedTab = title
        }) {
            VStack(spacing: 4) {
                Text(title)
                    .fontWeight(isSelected ? .bold : .regular)
                    .foregroundColor(.black)

                if isSelected {
                    Capsule()
                        .fill(Color.customYellowColor)
                        .frame(width: 120, height: 4)
                        .matchedGeometryEffect(id: "underline", in: underline)
                } else {
                    Color.clear.frame(height: 4)
                }
            }
            .frame(maxWidth: .infinity)
        }
    }
}

// MARK: - Preview

#Preview {
    OtherMapView()
}
