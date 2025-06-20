import SwiftUI
import MapKit

struct StoreMapView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel = StoreMapViewModel()
    @Namespace private var animation
    
    
    @State private var isCurrentLocation: Bool = true
       @State private var departure: String = ""
       @State private var destination: String = ""

    var body: some View {
        

        
        VStack(spacing: 20) {
            header
            segmentBar
            Divider()
            
            
            VStack(spacing: 20) {
                
                
                    HStack {
                                       Text("출발")
                            .font(.PretendardSemiBold(16))
                                       
                                       Button(action: {
                                           isCurrentLocation = true
                                           departure = ""
                                       }) {
                                           Text("현재위치")
                                               .font(.PretendardSemiBold(13))
                                               .frame(maxWidth: 58, maxHeight: 30)
                                               .foregroundColor(.white)
                                               .background(RoundedRectangle(cornerRadius: 6) .fill(.brown01))
                                               
                                               
                                       }
                                       

                        TextField("출발지 입력", text: $departure)
                            .font(.system(size: 16, weight: .regular))
                            .padding(.horizontal, 12)
                            .padding(.vertical, 10)
                            .background(
                                RoundedRectangle(cornerRadius: 4)
                                    .stroke(Color.gray.opacity(0.6), lineWidth: 1)
                            )
                            .frame(maxWidth: 237, maxHeight: 30)

                                       
                                       Image(systemName: "magnifyingglass")
                            .foregroundColor(.black02)
                                   }
                    
                
                HStack {
                                   Text("도착")
                        .font(.PretendardSemiBold(16))
                                   
                               
                              
                    TextField("매장명 또는 주소", text: $destination)
                        .font(.system(size: 16, weight: .regular))
                        .padding(.horizontal, 12)
                        .padding(.vertical, 10)
                        .background(
                            RoundedRectangle(cornerRadius: 4)
                                .stroke(Color.gray.opacity(0.6), lineWidth: 1)
                        )
                        .frame(maxWidth: 303, maxHeight: 30)

                                   
                                   Image(systemName: "magnifyingglass")
                        .foregroundColor(.black02)
                               }
                    
                    
                    
                    
                
                
            }
            
            
            Button (action: {
                
                print("경로 찾기")

            }, label: {
                Text("경로 찾기")
                    .font(.PretendardSemiBold(16))
                    .foregroundColor(.white)
                    .frame(maxWidth: 369, maxHeight: 38)
                    .background(RoundedRectangle(cornerRadius: 10) .fill(.green00))
            }).padding(.top, 30)
            
            
            
            ZStack(alignment: .top) {
                if viewModel.selectedSegment == .store {
                    mapView
                    searchHereButton
                    locationButton
                } else {
                    Text("길찾기ㄱㄱ")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.white)
                }
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .navigationBarBackButtonHidden(true)
    }

    private var header: some View {
        HStack {
            Button {
                dismiss()
            } label: {
                Image(systemName: "chevron.left")
                    .font(.title3)
                    .foregroundColor(.black)
            }
            Spacer()
            Text("매장 찾기")
                .font(.headline)
            Spacer()
        }
        .padding()
    }

    private var segmentBar: some View {
        HStack(spacing: 0) {
            ForEach(StoreMapSegment.allCases, id: \.self) { segment in
                Button {
                    withAnimation(.spring()) {
                        viewModel.selectedSegment = segment
                    }
                } label: {
                    VStack(spacing: 4) {
                        Text(segment.rawValue)
                            .font(.custom("Pretendard-Bold", size: 22))
                            .foregroundColor(viewModel.selectedSegment == segment ? .black : .gray)

                        if viewModel.selectedSegment == segment {
                            Rectangle()
                                .fill(Color.brown)
                                .frame(height: 2)
                                .matchedGeometryEffect(id: "underline", in: animation)
                        } else {
                            Color.clear.frame(height: 2)
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
            }
        }
        .padding(.horizontal)
        .background(Color.white)
    }
    
    
    //카메라 포지션
//    private var mapView: some View {
//        Map(position: $viewModel.cameraPosition) {
//            ForEach(viewModel.stores, id: \.id) { store in
//                Annotation(store.name, coordinate: store.coordinate) {
//                    Image("starbucks_pin") // ✅ 커스텀 핀 이미지
//                        .resizable()
//                        .frame(width: 44, height: 44)
//                        .clipShape(Circle())
//                        .overlay(Circle().stroke(Color.white, lineWidth: 2))
//                        .shadow(radius: 3)
//                        .onTapGesture {
//                            // 매장 상세 보기 로직
//                        }
//                        .offset(y: -22) // 핀 하단이 위치 중심에 맞도록
//                }
//            }
//
//            // 사용자 위치 핀
//            UserAnnotation()
//        }
//        .mapStyle(.standard)
//        .edgesIgnoringSafeArea(.bottom)
//    }

    

    private var mapView: some View {
        Map(coordinateRegion: $viewModel.region, annotationItems: viewModel.stores) { store in
            MapAnnotation(coordinate: store.coordinate) {
                Image("starbucks_pin") // ✅ 커스텀 핀
                    .resizable()
                    .frame(width: 44, height: 44)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 2))
                    .shadow(radius: 3)
                    .onTapGesture {
                        // 매장 상세 보기 연결 가능
                    }
                    .offset(y: -22) // 핀 하단이 위치 중심에 맞도록 조정
            }
        }
        .edgesIgnoringSafeArea(.bottom)
    }

    private var locationButton: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Button(action: {
                    viewModel.moveToCurrentLocation()
                }) {
                    Image(systemName: "location.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .foregroundColor(.white)
                        .padding(12)
                        .background(Color.black)
                        .clipShape(Circle())
                        .shadow(radius: 4)
                }
                .padding(.trailing, 16)
                .padding(.bottom, 40)
            }
        }
    }

    private var searchHereButton: some View {
        HStack {
            Spacer()
            Button(action: {
                print("이 지역 검색 실행")
                // 여기에 viewModel.refreshNearbyStores() 등 로직 연결 가능
            }) {
                Text("이 지역 검색")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.black)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 10)
                    .background(Color.white)
                    .cornerRadius(20)
                    .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
            }
            Spacer()
        }
        .padding(.top, 12)
    }
}

#Preview {
    StoreMapView()
}
