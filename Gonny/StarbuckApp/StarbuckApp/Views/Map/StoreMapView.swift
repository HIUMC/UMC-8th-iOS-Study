//
//  MapView.swift
//  StarbuckApp
//
//  Created by 박병선 on 4/30/25.
//
import Foundation
import Observation
import MapKit
import CoreLocation
import SwiftUI

struct StoreMapView: View {
    @ObservedObject var viewModel: MapViewModel
    @Bindable var locationManager: LocationManager
    @Namespace var mapScope
    @State private var hasMovedMap: Bool = false//사용자가 지도를 움직였는지 여부
    @State private var cameraInitialized: Bool = false
    @State private var mapCenter: CLLocationCoordinate2D?
    @State var markerUpdate: Bool = true
   

    var body: some View {
        MapReader { reader in
            ZStack(alignment: .bottomTrailing) {
                Map(position: $viewModel.cameraPosition, scope: mapScope) {
                    if let userLocation = locationManager.currentLocation?.coordinate {
                        ForEach(viewModel.markers, id: \.id) { marker in
                            Annotation(marker.title, coordinate: marker.coordinate) {
                                ZStack {
                                    Image("Marker")
                                        .resizable()
                                        .frame(width: 35, height: 41.7)
                                    
                                    Image("MarkerLogo")
                                        .resizable()
                                        .frame(width: 16.53, height: 16.77)
                                }
                            }
                        }
                        UserAnnotation()//Map안에 UserAnnotation() 사용되어서 현재 위치 마커 자동으로 표시됨
                        //위치 정보가 locationManager.currentLocation으로 업데이트되면 마커도 따라 움직임
                    }
    
            }
        
    }

                if hasMovedMap {
                    VStack(alignment: .center) {
                        HStack {
                            Spacer()
                            Button(action: {
                                let screenCenter = CGPoint(x: 390 / 2, y: 844 / 2)
                                if let center = reader.convert(screenCenter, from: .local) {
                                    viewModel.updateMarkers(around: center)
                                    hasMovedMap = false
                                    print("뭔가 바뀌네요?")
                                }
                            }) {
                                Text("이 지역 검색")
                                    .font(.mainTextMedium16)
                                    .foregroundColor(Color("black03"))
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 10)
                                    .background(
                                        RoundedRectangle(cornerRadius: 20)
                                            .fill(.white)
                                            .frame(width: 88, height: 36)
                                            .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 3)
                                    )
                            }
                            .padding(.bottom, 32)
                            .frame(maxWidth:.infinity)
                            .contentShape(Rectangle())
                        }
                        .padding(.top, 20)
                        Spacer()
                    }
                }
            }
            .mapScope(mapScope)
            
            .onAppear {//10km 내에 매장 보여주기
                if let userLoc = locationManager.currentLocation {
                    viewModel.loadNearbyStores(userLocation: userLoc)
                }
            }
            
       
//왜 지도위치를 이동해도 새로운 매장이 뜨지 않는거지? 얘 때문에(이유: SwiftUI에서 Map의 cameraPosition은 바인딩으로는 변화를 감지 못 할 때가 많음)
            .onChange(of: viewModel.cameraPosition) { newValue in
                print("카메라 위치 바뀜: \(newValue)")
                // 처음 한 번은 무시
                if !cameraInitialized {
                    cameraInitialized = true
                    return
                }
                // 여기 도달했으면 드래그 or 유저 조작이라 판단
                hasMovedMap = true
            }
             
            //.onRegionChange는 MapReader가 아니라 Map에 직접 붙여야 함
            /*.onRegionChange { region in
                hasMovedMap = true
                mapCenter = region.center
                print("지도 이동됨, 중심 좌표: \(region.center)")
            }
             */
        }
    }

