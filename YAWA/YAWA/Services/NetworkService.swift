//
//  NetworkService.swift
//  YAWA
//
//  Created by Bassist Zero on 12/13/23.
//

import Foundation
import CoreLocation.CLLocation
import UIKit.UIImage
import CoreLocation

protocol NetworkService {
    func loadCurrentWeather(location: CLLocationCoordinate2D, completion: @escaping (WeatherModel) -> Void)
    func loadCurrentForecast(location: CLLocationCoordinate2D, completion: @escaping (HourlyForecastModel) -> Void)

    func loadCityWeather(city: String, completion: @escaping (WeatherModel) -> Void)
    func loadCityForecast(city: String, completion: @escaping (HourlyForecastModel) -> Void)

    func downloadWeatherConditionImage(from url: URL, completion: @escaping (UIImage) -> Void)
}

final class NetworkServiceImpl:NetworkService {

    static var shared = NetworkServiceImpl()
    private init() { }

    private let baseURL = "https://api.openweathermap.org/data/2.5"
    private let appid = "5794a90661fd4a193a5a4e22da9f6945"

    func loadCurrentForecast(location: CLLocationCoordinate2D, completion: @escaping (HourlyForecastModel) -> Void) {
        let url = URL(string: "\(baseURL)/forecast/?lat=\(location.latitude)&lon=\(location.longitude)&exclude=current,minutely,alerts&units=metric&cnt=9&appid=\(appid)")!

        getJSONData(as: HourlyForecastModel.self, from: url) { forecast in
            completion(forecast)
        }
    }



    func loadCurrentWeather(location: CLLocationCoordinate2D, completion: @escaping (WeatherModel) -> Void) {
        let url = URL(string: "\(baseURL)/weather?lat=\(location.latitude)&lon=\(location.longitude)&exclude=current,minutely,hourly,alerts&units=metric&appid=\(appid)")!

        getJSONData(as: WeatherModel.self, from: url) { weather in
            completion(weather)
        }
    }

    func loadCityWeather(city: String, completion: @escaping (WeatherModel) -> Void) {
        getCityCoordinates(city: city) { cityCoordinates in
            self.loadCurrentWeather(location: cityCoordinates) { weather in
                completion(weather)
            }
        }
    }

    func loadCityForecast(city: String, completion: @escaping (HourlyForecastModel) -> Void) {
        getCityCoordinates(city: city) { cityCoordinates in
            self.loadCurrentForecast(location: cityCoordinates) { forecast in
                completion(forecast)
            }
        }
    }

    func downloadWeatherConditionImage(from url: URL, completion: @escaping (UIImage) -> Void) {
        let request = URLRequest(url: url)
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            let weatherConditionImage = UIImage(data: data!)!
            completion(weatherConditionImage)
        }
        dataTask.resume()
    }

}

// MARK: - NetworkServiceImpl

private extension NetworkServiceImpl {

        func getJSONData<T: Decodable>(as type: T.Type, from url: URL, completion: @escaping (T) -> Void) {
            let request = URLRequest(url: url)
    
            let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
    
                let data = try! jsonDecoder.decode(T.self, from: data!)
    
                completion(data)
            }
    
            dataTask.resume()
        }

    func getCityCoordinates(city: String, completion: @escaping (CLLocationCoordinate2D) -> Void) {
        let city = city.capitalized
        let url = URL(string: "https://api.openweathermap.org/geo/1.0/direct?q=\(city)&appid=5794a90661fd4a193a5a4e22da9f6945")!

        getJSONData(as: CityCoordinatesModel.self, from: url) { cityCoordinates in
            let cityCoordinates = cityCoordinates[0]
            let coordinates = CLLocationCoordinate2D(latitude: cityCoordinates.lat, longitude: cityCoordinates.lon)
            completion(coordinates)
        }
    }
}

