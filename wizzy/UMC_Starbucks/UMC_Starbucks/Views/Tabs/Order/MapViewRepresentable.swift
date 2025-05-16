//
//  MapViewRepresentable.swift
//  UMC_Starbucks
//
//  Created by 이서현 on 5/6/25.
//

import SwiftUI
import MapKit

struct MapViewRepresentable: UIViewRepresentable {
    @Binding var selectedCoordinate: CLLocationCoordinate2D?
    @Binding var cameraCenter: CLLocationCoordinate2D?
    @Binding var hasMoved: Bool
    @Binding var markers: [Marker] // 마커 리스트.. title과 coordinate를 가진 Marker 모델
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator // 델리게이트 연결 .?
        mapView.showsUserLocation = true // 현재 위치 보여주기
        mapView.userTrackingMode = .follow
        
        return mapView
    }
    
    
    // SwiftUI 상태 값이 변경될 때마다 호출되어 뷰 업데이트
    func updateUIView(_ mapView: MKMapView, context: Context) {
        mapView.removeAnnotations(mapView.annotations)
        let annotations = markers.map { marker -> MKPointAnnotation in
            let annotation = MKPointAnnotation()
            annotation.title = marker.title
            annotation.coordinate = marker.coordinate
            return annotation
        }
        mapView.addAnnotations(annotations)
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapViewRepresentable
        
        init(_ parent: MapViewRepresentable) {
            self.parent = parent
        }
        
        func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
            print("지도 이동 감지됨!")
            DispatchQueue.main.async {
                let center = mapView.centerCoordinate
                self.parent.cameraCenter = center
                self.parent.selectedCoordinate = center
                self.parent.hasMoved = true
                print("중심 좌표 변경됨: \(center.latitude), \(center.longitude)")
            }
        }

        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? { //gpt..
            if annotation is MKUserLocation { //사용자 위치는 시스템 기본 마커
                return nil
            }

            let identifier = "CustomMarker"
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)

            if annotationView == nil { //시스템 기본 마커 대신 커스텀 이미지로 표시
                annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                annotationView?.canShowCallout = true
                annotationView?.image = UIImage(named: "marker")
                annotationView?.frame.size = CGSize(width: 30, height: 40)
            } else {
                annotationView?.annotation = annotation
            }

            return annotationView
        }
        
        
        
    }
    
    
    
}
