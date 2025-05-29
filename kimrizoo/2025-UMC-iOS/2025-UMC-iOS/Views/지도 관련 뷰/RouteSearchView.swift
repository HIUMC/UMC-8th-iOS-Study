import SwiftUI

struct RouteSearchView: View {
    @State private var departureText = ""
    @State private var arrivalText = ""
    @State private var departureSearchResults: [KakaoPlace] = []
    @State private var arrivalSearchResults: [KakaoPlace] = []

    @Bindable var mapViewModel: MapViewModel

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                LocationInputRow(
                    title: "출발",
                    text: $departureText,
                    showCurrentLocation: true,
                    onSearch: {
                        mapViewModel.searchPlaces(by: departureText) { places in
                            DispatchQueue.main.async {
                                departureSearchResults = places
                            }
                        }
                    },
                    onCurrentLocationTap: {
                        Task {
                            let address = await mapViewModel.getCurrentAddress()
                            departureText = address
                        }
                    }
                )

                if !departureSearchResults.isEmpty {
                    SearchResultsList(
                        results: departureSearchResults,
                        onSelect: { selected in
                            departureText = selected.placeName
                            departureSearchResults = []
                        }
                    )
                }

                LocationInputRow(
                    title: "도착",
                    text: $arrivalText,
                    showCurrentLocation: false,
                    onSearch: {
                        // 도착지 검색
                        mapViewModel.searchArrivalStores(by: arrivalText) { places in
                                    DispatchQueue.main.async {
                                        arrivalSearchResults = places
                            }
                        }
                    }
                )
                
                if !arrivalSearchResults.isEmpty {
                    SearchResultsList(
                        results: arrivalSearchResults,
                        onSelect: { selected in
                            arrivalText = selected.placeName
                            arrivalSearchResults = []
                        }
                    )
                }

                ActionButton(title: "경로 찾기") {
                    // 경로 검색 처리 예정
                }

                Spacer(minLength: 40)
            }
            .padding(.top)
        }
    }
}

// MARK: - 검색칸
struct LocationInputRow: View {
    let title: String
    @Binding var text: String
    var showCurrentLocation: Bool = false
    var onSearch: () -> Void
    var onCurrentLocationTap: (() -> Void)? = nil

    var body: some View {
        HStack {
            Text(title)
                .frame(width: 40, alignment: .leading)

            if showCurrentLocation, let onCurrentLocationTap = onCurrentLocationTap {
                Button("현재위치", action: onCurrentLocationTap)
                    .font(.caption)
                    .padding(6)
                    .background(Color.orange.opacity(0.2))
                    .cornerRadius(5)
            }

            TextField("\(title)지 입력", text: $text)
                .textFieldStyle(RoundedBorderTextFieldStyle())

            Button {
                UIApplication.shared.hideKeyboard()
                onSearch()
            } label: {
                Image(systemName: "magnifyingglass")
            }
        }
        .padding(.horizontal)
    }
}

// MARK: - 검색결과 리스트 뷰
struct SearchResultsList: View {
    let results: [KakaoPlace]
    let onSelect: (KakaoPlace) -> Void

    var body: some View {
        VStack(spacing: 0) {
            ForEach(results) { place in
                VStack(alignment: .leading, spacing: 4) {
                    Text(place.placeName)
                        .font(.body)
                        .bold()
                    Text(place.addressName)
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.white)
                .contentShape(Rectangle())
                .onTapGesture { onSelect(place) }

                Divider()
            }
        }
        .background(Color(.systemGray6))
        .cornerRadius(8)
        .padding(.horizontal)
    }
}

struct ActionButton: View {
    let title: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .frame(maxWidth: .infinity)
                .frame(height: 44)
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(8)
                .padding(.horizontal)
        }
    }
}

// MARK: - 키보드 숨기기
#if canImport(UIKit)
extension UIApplication {
    func hideKeyboard() {
        sendAction(#selector(UIResponder.resignFirstResponder),
                   to: nil, from: nil, for: nil)
    }
}
#endif

#Preview {
    RouteSearchView(mapViewModel: MapViewModel())
}
