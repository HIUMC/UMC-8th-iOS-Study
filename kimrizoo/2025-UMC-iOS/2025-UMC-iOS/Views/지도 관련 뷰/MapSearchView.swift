import SwiftUI
import MapKit

struct MapSearchView: View {
    
    @Bindable private var locationManager = LocationManager.shared
    @Bindable var viewModel: MapViewModel
    
    var body: some View {
        ZStack(alignment: .top) {
            // 지도 표시
            Map(position: $viewModel.cameraPosition) {
                ForEach(viewModel.makers, id: \.id) { marker in
                    Annotation(marker.title, coordinate: marker.coordinate) {
                        Image("Marker") // 에셋에 있는 스타벅스 마커 이미지
                            .resizable()
                            .scaledToFit()
                            .frame(width: 32, height: 32)
                    }
                }
                
                // 현재 위치 마커
                UserAnnotation(anchor: .center)
            }
            .onMapCameraChange { context in
                viewModel.currentMapCenter = context.region.center

                // 초기 진입이 아닌 경우에만 버튼 활성화
                if viewModel.hasInitializedCamera {
                    viewModel.isMapMovedByUser = true
                } else {
                    viewModel.hasInitializedCamera = true
                }
            }
            .task {
                viewModel.updateFromLocation(locationManager.currentLocation)
            }

            // “이 지역 검색” 버튼
            if viewModel.isMapMovedByUser {
                VStack {
                    
                    Spacer().frame(height: 10)
                    
                    Button(action: {
                        Task {
                            await viewModel.searchStoresNearMapCenter()
                        }
                    }) {
                        Text("이 지역 검색")
                            .font(.customPretend(.regular, size: 13))
                            .foregroundColor(.customGray2)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 7)
                            .background(Color.white)
                            .clipShape(Capsule())
                            .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 1)
                    }
                    .transition(.opacity)
                    .animation(.easeInOut, value: viewModel.isMapMovedByUser)
                }
            }
        }
    }
}

#Preview {
    MapSearchView(viewModel: MapViewModel())
}
