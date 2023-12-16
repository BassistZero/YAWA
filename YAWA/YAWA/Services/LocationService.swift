//
//  LocationService.swift
//  YAWA
//
//  Created by Bassist Zero on 12/14/23.
//

import CoreLocation

final class LocationService: NSObject {
    
    private let manager = CLLocationManager()

    var status: CLAuthorizationStatus {
        manager.authorizationStatus
    }

    weak var presenter: CityWeatherPresenterDelegate?

    func requestPermission() {
        DispatchQueue.global(qos: .background).async {
            self.manager.delegate = self
            self.manager.desiredAccuracy = kCLLocationAccuracyHundredMeters
            self.manager.requestWhenInUseAuthorization()
        }
    }

    func getCurrentLocation(completion: (CLLocationCoordinate2D) -> Void) {
        guard let location = manager.location else { return }

        completion(location.coordinate)
    }

    func requestLocationWeather(for status: CLAuthorizationStatus? = nil) {
        let currentStatus: CLAuthorizationStatus?

        currentStatus = status != nil ? status : self.status

        switch currentStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            presenter?.getLocationWeather()
        default:
            break
        }
    }

}

// MARK: - CLLocationManagerDelegate

extension LocationService: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        requestLocationWeather(for: status)
    }

}
