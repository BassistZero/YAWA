//
//  LocationService.swift
//  YAWA
//
//  Created by Bassist Zero on 12/14/23.
//

import CoreLocation

final class LocationService: NSObject {
    private let manager = CLLocationManager()

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

}

// MARK: - Private Methods

private extension LocationService {

}

// MARK: - CLLocationManagerDelegate

extension LocationService: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // FIXME - Handle something
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // FIXME - Handle the error
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            presenter?.getCityWeather()
            presenter?.getForecastWeather()
            manager.requestLocation()
        default:
            break
        }
    }

}
