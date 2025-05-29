import SwiftUI

struct RouteSearchView: View {
    @State private var departureText: String = ""
    @State private var arrivalText: String = ""
    @State private var departureSearchResults: [KakaoPlace] = []

    @Bindable var mapViewModel: MapViewModel

    var body: some View {
        VStack(spacing: 20) {
            // 출발지 입력
            HStack {
                Text("출발")
                    .frame(width: 40, alignment: .leading)

                Button("현재위치") {
                    Task {
                        let address = await mapViewModel.getCurrentAddress()
                        departureText = address
                    }
                }
                .font(.caption)
                .padding(6)
                .background(Color.orange.opacity(0.2))
                .cornerRadius(5)

                TextField("출발지 입력", text: $departureText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                Button(action: {
                    mapViewModel.searchPlaces(by: departureText) { places in
                        DispatchQueue.main.async {
                            departureSearchResults = places
                        }
                    }
                }) {
                    Image(systemName: "magnifyingglass")
                }
            }
            .padding(.horizontal)

            // 검색 결과 리스트
            if !departureSearchResults.isEmpty {
                VStack(spacing: 0) {
                    ForEach(departureSearchResults) { place in
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
                        .onTapGesture {
                            departureText = place.placeName
                            departureSearchResults = []
                        }

                        Divider()
                    }
                }
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal)
            }

            // 도착지 입력
            HStack {
                Text("도착")
                    .frame(width: 40, alignment: .leading)

                TextField("매장명 또는 주소", text: $arrivalText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                Button {
                    // 도착지 검색 버튼 구현 시 여기에
                } label: {
                    Image(systemName: "magnifyingglass")
                }
            }
            .padding(.horizontal)

            // 경로 찾기 버튼
            Button(action: {
                // 경로 검색 처리
            }) {
                Text("경로 찾기")
                    .frame(maxWidth: .infinity)
                    .frame(height: 44)
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .padding(.horizontal)
            }

            Spacer()
        }
    }
}

#Preview {
    RouteSearchView(mapViewModel: MapViewModel())
}
