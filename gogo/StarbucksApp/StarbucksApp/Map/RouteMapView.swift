//
//  RouteMapView.swift
//  StarbucksApp
//
//  Created by 고석현 on 5/28/25.
//

//

//
//import SwiftUI
//import CoreLocation
//import MapKit
//
//struct RouteMapView: UIViewRepresentable { //SwiftUI와 UIKit의 MKMapView를 연결하기 위해 사용
//    @ObservedObject var viewModel: RouteViewModel
//
//    func makeUIView(context: Context) -> MKMapView {
//        let mapView = MKMapView()
//        mapView.delegate = context.coordinator
//        mapView.showsUserLocation = false
//        mapView.isZoomEnabled = true
//        mapView.isScrollEnabled = true
//        return mapView
//    }
//
//    func updateUIView(_ uiView: MKMapView, context: Context) {
//        guard let route = viewModel.route else {
//            print("❌ route 없음")
//            return
//        }
//
//        let coordinates = route.geometry.coordinates.toCoordinate2DList()
//        guard !coordinates.isEmpty else {
//            print("❌ 좌표가 비어 있음")
//            return
//        }
//
//        print("🟢 경로 좌표 수: \(coordinates.count)")
//        for coord in coordinates {
//            print("🧭 \(coord.latitude), \(coord.longitude)")
//        }
//
//        uiView.removeOverlays(uiView.overlays)
//        let polyline = MKPolyline(coordinates: coordinates, count: coordinates.count)
//        print("🟢 updateUIView 호출됨 - 좌표 수: \(coordinates.count)")
//        for coord in coordinates {
//            print("🧭 updateUIView 경로 좌표: \(coord.latitude), \(coord.longitude)")
//        }
//        uiView.addOverlay(polyline)
//
//        if let first = coordinates.first {
//            var regionRect = MKMapRect(origin: MKMapPoint(first), size: MKMapSize(width: 0, height: 0))
//            for coord in coordinates {
//                let point = MKMapPoint(coord)
//                regionRect = regionRect.union(MKMapRect(origin: point, size: MKMapSize(width: 0, height: 0)))
//            }
//            uiView.setVisibleMapRect(regionRect, edgePadding: UIEdgeInsets(top: 40, left: 40, bottom: 40, right: 40), animated: true)
//        }
//    }
//
//    func makeCoordinator() -> Coordinator {
//        Coordinator(self)
//    }
//
//    class Coordinator: NSObject, MKMapViewDelegate {
//        var parent: RouteMapView
//
//        init(_ parent: RouteMapView) {
//            self.parent = parent
//        }
//
//        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer { //Polyline 스타일 설정
//            if let polyline = overlay as? MKPolyline {
//                let renderer = MKPolylineRenderer(polyline: polyline)
//                renderer.strokeColor = UIColor.systemGreen
//                renderer.lineWidth = 5
//                return renderer
//            }
//            return MKOverlayRenderer(overlay: overlay)
//        }
//    }
//}
///*
//import SwiftUI
//import MapKit
//import CoreLocation
//
//struct RouteMapView: View {
//    let coordinates: [CLLocationCoordinate2D]
//
//    var body: some View {
//        MapViewWithPolyline(coordinates: coordinates)
//            .edgesIgnoringSafeArea(.all)
//    }
//}
//
//struct MapViewWithPolyline: UIViewRepresentable {
//    let coordinates: [CLLocationCoordinate2D]
//
//    func makeUIView(context: Context) -> MKMapView {
//        let mapView = MKMapView()
//        mapView.delegate = context.coordinator
//        mapView.showsUserLocation = true
//        return mapView
//    }
//
//    func updateUIView(_ uiView: MKMapView, context: Context) {
//        uiView.removeOverlays(uiView.overlays)
//        if let first = coordinates.first {
//            let region = MKCoordinateRegion(center: first, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
//            uiView.setRegion(region, animated: true)
//        }
//
//        let polyline = MKPolyline(coordinates: coordinates, count: coordinates.count)
//        uiView.addOverlay(polyline)
//    }
//
//    func makeCoordinator() -> Coordinator {
//        Coordinator()
//    }
//
//    class Coordinator: NSObject, MKMapViewDelegate {
//        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
//            if let polyline = overlay as? MKPolyline {
//                let renderer = MKPolylineRenderer(polyline: polyline)
//                renderer.strokeColor = .systemBlue
//                renderer.lineWidth = 4
//                return renderer
//            }
//            return MKOverlayRenderer()
//        }
//    }
//}
//
////OSRM에서 받은 좌표를 CLLocationCoordinate2D(latitude:lat, longitude:lon) 형식으로 자동 변환
//extension Array where Element == [Double] {
//    func toCoordinate2DList() -> [CLLocationCoordinate2D] {
//        self.compactMap { pair in
//            guard pair.count == 2 else { return nil }
//            return CLLocationCoordinate2D(latitude: pair[1], longitude: pair[0])
//        }
//    }
//}
//
//#Preview {
//    // 예시
//    let coords = [
//        CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
//        CLLocationCoordinate2D(latitude: 37.7793, longitude: -122.4192),
//        CLLocationCoordinate2D(latitude: 37.3327, longitude: -122.0053)
//    ]
//    return RouteMapView(coordinates: coords)
//}
//
////뷰모델이랑 연결?
//*/
