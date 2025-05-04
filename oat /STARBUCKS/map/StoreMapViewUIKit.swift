//
//  StoreMapViewUIKit.swift
//  STARBUCKS
//
//  Created by 신민정 on 5/2/25.
//

import SwiftUI
import MapKit

struct StoreMapViewUIKit: UIViewRepresentable {
    var stores: [Store]
    @Binding var hasMoved: Bool
    @Binding var displayedStores: [Store]
    var userLocation: CLLocation?
    var onRegionChange: ((CLLocationCoordinate2D) -> Void)? = nil
  

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        mapView.showsUserLocation = true
        mapView.isRotateEnabled = true
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        if !context.coordinator.hasSetInitialRegion, let location = userLocation {
            let camera = MKMapCamera(lookingAtCenter: location.coordinate,
                                     fromDistance: 3000,
                                     pitch: 0,
                                     heading: 0)
            uiView.setCamera(camera, animated: true)
            context.coordinator.hasSetInitialRegion = true
        }
        
   
        uiView.removeAnnotations(uiView.annotations)
        

        let annotations = displayedStores.map { store -> MKPointAnnotation in
            let annotation = MKPointAnnotation()
            annotation.title = store.name
            annotation.coordinate = CLLocationCoordinate2D(latitude: store.latitude,
                                                            longitude: store.longitude)
            return annotation
        }
        uiView.addAnnotations(annotations)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: StoreMapViewUIKit
        var hasSetInitialRegion = false //
        
        init(_ parent: StoreMapViewUIKit) {
            self.parent = parent
        }
        
        func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
            DispatchQueue.main.async {
                self.parent.hasMoved = true
                self.parent.onRegionChange?(mapView.centerCoordinate)
            }
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            if annotation is MKUserLocation {
                return nil
            }
            
            let identifier = "CustomPin"
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            
            if annotationView == nil {
                annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                annotationView?.canShowCallout = true
                
                
                let pinImage = UIImage(systemName: "mappin.circle.fill")?
                    .withTintColor(UIColor(named: "green03") ?? .green, renderingMode: .alwaysOriginal)
                
               
                let pinSize = CGSize(width: 44, height: 44)
                UIGraphicsBeginImageContextWithOptions(pinSize, false, 0.0)
                
              
                pinImage?.draw(in: CGRect(x: 0, y: 0, width: 44, height: 44))
                
             
                if let logo = UIImage(named: "starbuckLogo") {
                    logo.draw(in: CGRect(x: 12, y: 12, width: 20, height: 20))
                }
                
         
                let finalImage = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
                
                annotationView?.image = finalImage
            } else {
                annotationView?.annotation = annotation
            }
            
            return annotationView
        }

    }
}
