//
//  UIKitMapView.swift
//  cloneStarbucks
//
//  Created by tokkislove on 5/1/25.
//

import SwiftUI
import MapKit

struct UIKitMapView: UIViewRepresentable {
    @EnvironmentObject var mapViewModel: MapViewModel
    
    @Binding var cameraCenter: CLLocationCoordinate2D?
    @Binding var hasMovedMap: Bool
    @Binding var markers: [Marker]
    @Binding var markerUpdate: Bool
    var mapState: StoreMapStateViewModel
    var initialRegion: MKCoordinateRegion?

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: Context) -> MKMapView { // MKMapView 자체가 UIView를 상속한 클래스
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        mapView.isRotateEnabled = false
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .none

        let gesture = UIPanGestureRecognizer(target: context.coordinator, action: #selector(context.coordinator.handlePan(_:)))
        gesture.delegate = context.coordinator
        gesture.cancelsTouchesInView = false
        mapView.addGestureRecognizer(gesture)
        
        if let region = initialRegion {
            mapView.setRegion(region, animated: false)
        }

        return mapView
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
        if markerUpdate {
            updateMarkers(on: uiView, with: markers)
            DispatchQueue.main.async {
                markerUpdate = false
            }
        }
        if mapState.shouldMoveToUserLocation {
            context.coordinator.moveToUserLocation(uiView)
            DispatchQueue.main.async {
                mapState.shouldMoveToUserLocation = false
            }
        }
        
        if !mapViewModel.routePoints.isEmpty {
            //update route 함수 실행
            updateRoute(on: uiView, with: mapViewModel.routePoints)
            DispatchQueue.main.async {
                mapViewModel.routePoints = []
            }
        }
    }
    
    func updateMarkers(on mapView: MKMapView, with markers: [Marker]) {
        mapView.removeAnnotations(mapView.annotations.filter { !($0 is MKUserLocation) })
        for marker in markers {
            let annotation = MKPointAnnotation()
            annotation.coordinate = marker.coordinate
            annotation.title = marker.title
            mapView.addAnnotation(annotation)
        }
    }
    
    func updateRoute(on mapView: MKMapView, with points: [CLLocationCoordinate2D]) {
        print("routePoints count: \(points.count)")
        print("points: \(points)")
        // Remove existing polylines (but keep annotations)
        let existingPolylines = mapView.overlays.filter { $0 is MKPolyline }
        mapView.removeOverlays(existingPolylines)

        // Add new route as polyline
        let polyline = MKPolyline(coordinates: points, count: points.count)
        mapView.addOverlay(polyline)
    }
    
    

    // MARK: - Coordinator
    class Coordinator: NSObject, MKMapViewDelegate, UIGestureRecognizerDelegate {
        var parent: UIKitMapView

        init(_ parent: UIKitMapView) {
            self.parent = parent
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            if annotation is MKUserLocation {
                return nil
            }

            let identifier = "CustomMarker"
            var view = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)

            if view == nil {
                view = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view?.image = UIImage(named: "marker")
                view?.canShowCallout = true
            } else {
                view?.annotation = annotation
            }

            return view
        }
        
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            if let polyline = overlay as? MKPolyline {
                let renderer = MKPolylineRenderer(polyline: polyline)
                renderer.strokeColor = .green02
                renderer.lineWidth = 5
                return renderer
            }
            return MKOverlayRenderer(overlay: overlay)
        }

        @objc func handlePan(_ gestureRecognizer: UIPanGestureRecognizer) {
            guard gestureRecognizer.state == .ended else { return }
            parent.hasMovedMap = true
        }

        // 지도의 '가시영역'이 바뀔 때마다 호출됨. 현재 보이는 지도 화면의 중심 좌표를 cameraCenter에 계속 반영해주는 역할을 한다.
        func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
            parent.cameraCenter = mapView.centerCoordinate
            
        }
        
        func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
            return true
        }
        
        func moveToUserLocation(_ mapView: MKMapView) {
            guard let userLocation = LocationManager.shared.currentLocation else { return }

            let region = MKCoordinateRegion(
                center: userLocation.coordinate,
                span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            )

            mapView.setRegion(region, animated: true)
        }
    }
}
