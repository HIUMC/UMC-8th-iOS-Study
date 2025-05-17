import Foundation
import CoreLocation
import Observation

@Observable
final class MapViewModel: NSObject, CLLocationManagerDelegate {
    var nearbyStores: [StoreFeature] = []
    
    private var allStores: [StoreFeature] = []
    private let locationManager = CLLocationManager()
    private var userLocation: CLLocation?

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    func updateStoreList(with stores: [StoreFeature]) {
        self.allStores = stores
        if let loc = userLocation {
            sortStores(from: loc)
        }
    }

    private func sortStores(from location: CLLocation) {
        self.nearbyStores = allStores.sorted {
            let loc1 = CLLocation(latitude: $0.properties.yCoordinate, longitude: $0.properties.xCoordinate)
            let loc2 = CLLocation(latitude: $1.properties.yCoordinate, longitude: $1.properties.xCoordinate)
            return loc1.distance(from: location) < loc2.distance(from: location)
        }
    }

    // CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let loc = locations.last {
            self.userLocation = loc
            sortStores(from: loc)
        }
    }
}
