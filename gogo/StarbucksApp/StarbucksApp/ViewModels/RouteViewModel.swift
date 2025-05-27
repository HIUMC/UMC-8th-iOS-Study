//
//  RouteViewModel.swift
//  StarbucksApp
//

//import Foundation
//import CoreLocation
//
//class RouteViewModel: ObservableObject {
//    @Published var route: RouteData?
//    @Published var isLoading: Bool = false
//
//    private let service = RouteService()
//
//    func fetchRoute(start: CLLocationCoordinate2D, end: CLLocationCoordinate2D, profile: OSRMProfile) { // 출발지와 도착지 좌표를 받아옴
//        isLoading = true
//        service.fetchRoute(start: start, end: end, profile: profile) { result in
//            DispatchQueue.main.async {
//                self.route = result
//                self.isLoading = false
//            }
//        }
//    }
//}
//
//extension Array where Element == [Double] { //gpt
//    func toCoordinate2DList() -> [CLLocationCoordinate2D] {
//        self.compactMap { pair in
//            if pair.count >= 2 {
//                return CLLocationCoordinate2D(latitude: pair[1], longitude: pair[0])
//            } else {
//                return nil
//            }
//        }
//    }
//}
