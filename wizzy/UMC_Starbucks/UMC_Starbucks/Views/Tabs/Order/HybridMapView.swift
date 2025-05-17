//  HybridMapView.swift
//  UMC_Starbucks
//
//  Created by 이서현 on 5/3/25.
//

import SwiftUI
import MapKit

struct HybridMapView: UIViewRepresentable {
    @Binding var selectedCoordinate: CLLocationCoordinate2D?
    @Binding var cameraCenter: CLLocationCoordinate2D?
    @Binding var hasMoved: Bool
    @Binding var markers: [Marker]  // viewModel에서 사용하는 구조체

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        mapView.isRotateEnabled = false
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .none

        let gesture = UILongPressGestureRecognizer(target: context.coordinator, action: #selector(context.coordinator.handleLongPress(_:)))
        mapView.addGestureRecognizer(gesture)

        return mapView
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
        uiView.removeAnnotations(uiView.annotations)

        // Add annotations for each marker
        for marker in markers {
            let annotation = MKPointAnnotation()
            annotation.coordinate = marker.coordinate
            annotation.title = marker.title
            uiView.addAnnotation(annotation)
        }

        // Add selected coordinate annotation if available
        if let coordinate = selectedCoordinate {
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = "선택한 위치"
            uiView.addAnnotation(annotation)
        }
    }

    // MARK: - Coordinator
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: HybridMapView

        init(_ parent: HybridMapView) {
            self.parent = parent
        }
        
        
        @objc func handleLongPress(_ gestureRecognizer: UILongPressGestureRecognizer) {
            guard gestureRecognizer.state == .began,
                  let mapView = gestureRecognizer.view as? MKMapView else { return }

            let point = gestureRecognizer.location(in: mapView)
            let coordinate = mapView.convert(point, toCoordinateFrom: mapView)
            parent.selectedCoordinate = coordinate
        }
         
        
        func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {//지도의 영역을 변경할 때마다 mapViewDidChangeVisibleRegion이 자동으로 호출
            DispatchQueue.main.async {
                self.parent.cameraCenter = mapView.centerCoordinate
                self.parent.selectedCoordinate = mapView.centerCoordinate
                self.parent.hasMoved = true
            }
        }
       
    }
}
