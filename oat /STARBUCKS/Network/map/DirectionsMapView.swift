//
//  DirectionsMapView.swift
//  STARBUCKS
//
//  Created by 신민정 on 5/20/25.
//
//지도에 경로(선) 그려주는 뷰

import SwiftUI
import MapKit

struct DirectionsMapView: UIViewRepresentable {
    //coordinates: 여러 위치를 담고 있는 리스트 (선)
    @Binding var coordinates: [CLLocationCoordinate2D] //경로 좌표
   

    let mapView = MKMapView()

    func makeUIView(context: Context) -> MKMapView {
        mapView.delegate = context.coordinator //오버레이 그리기
        mapView.showsUserLocation = true // 사용자의 현재 위치 지도에 표시
        return mapView
    }
    
//coordinates 바뀌면 updateUIView 다시 호출
    func updateUIView(_ uiView: MKMapView, context: Context) {
        uiView.removeOverlays(uiView.overlays) // 이전에 그린 선들을 제거
        
  // 경로가 있을 때.. MKPolyline을 만들자!
        if !coordinates.isEmpty {
            let polyline = MKPolyline(coordinates: coordinates, count: coordinates.count)
            uiView.addOverlay(polyline) // 지도에 선 추가

            if !context.coordinator.userHasInteracted {
                let region = MKCoordinateRegion(polyline.boundingMapRect)
                uiView.setRegion(region, animated: true)
                       }
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: DirectionsMapView
        var userHasInteracted = false

        init(_ parent: DirectionsMapView) {
            self.parent = parent
        }
        
        func mapView(_ mapView: MKMapView, regionWillChangeAnimated animated: Bool) {
            userHasInteracted = true
        }

        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            //선 시각화
            if let polyline = overlay as? MKPolyline {
                let renderer = MKPolylineRenderer(polyline: polyline)
                renderer.strokeColor = .blue
                renderer.lineWidth = 4
                return renderer
            }
            return MKOverlayRenderer(overlay: overlay)
        }
    }
}


