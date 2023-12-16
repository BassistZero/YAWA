//
//  NetworkService.swift
//  YAWA
//
//  Created by Bassist Zero on 12/13/23.
//

import Foundation
import UIKit.UIImage
import CoreLocation

protocol NetworkService {
    func loadCurrentWeather(location: CLLocationCoordinate2D, completion: @escaping (WeatherModel) -> Void)
    func loadCurrentForecast(location: CLLocationCoordinate2D, completion: @escaping (HourlyForecastModel) -> Void)

    func loadCityWeather(city: String, completion: @escaping (WeatherModel) -> Void)
    func loadCityForecast(city: String, completion: @escaping (HourlyForecastModel) -> Void)

    func downloadWeatherConditionImage(from url: URL, completion: @escaping (UIImage) -> Void)
}

final class NetworkServiceImpl: NetworkService {

    static var shared = NetworkServiceImpl()
    private init() { }

    private let baseURL = "https://api.openweathermap.org/data/2.5"
    private let appid = "5794a90661fd4a193a5a4e22da9f6945"

    func loadCurrentForecast(location: CLLocationCoordinate2D, completion: @escaping (HourlyForecastModel) -> Void) {
        let url = URL(string: "\(baseURL)/forecast/?lat=\(location.latitude)&lon=\(location.longitude)&exclude=current,minutely,alerts&units=metric&cnt=9&appid=\(appid)")!

        getJSONData(as: HourlyForecastModel.self, from: url) { forecast in
            switch forecast {
            case .success(let forecast):
                completion(forecast)
            case .failure:
                break
            }
        }
    }

    func loadCurrentWeather(location: CLLocationCoordinate2D, completion: @escaping (WeatherModel) -> Void) {
        let url = URL(string: "\(baseURL)/weather?lat=\(location.latitude)&lon=\(location.longitude)&exclude=current,minutely,hourly,alerts&units=metric&appid=\(appid)")!

        getJSONData(as: WeatherModel.self, from: url) { weather in
            switch weather {
            case .success(let weather):
                completion(weather)
            case .failure:
                break
            }
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
        let dataTask = URLSession.shared.dataTask(with: request) { data, _, _ in
            let weatherConditionImage = UIImage(data: data!)!
            completion(weatherConditionImage)
        }
        dataTask.resume()
    }

}

// MARK: - NetworkServiceImpl

private extension NetworkServiceImpl {

        func getJSONData<T: Decodable>(as type: T.Type, from url: URL, completion: @escaping (Result<T, NetworkError>) -> Void) {
            let request = URLRequest(url: url)

            let dataTask = URLSession.shared.dataTask(with: request) { data, _, _ in
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase

                guard let data else {
                    completion(Result.failure(NetworkError.noData))
                    return
                }
                guard let decodedData = try? jsonDecoder.decode(T.self, from: data) else {
                    completion(Result.failure(NetworkError.corruptedJSON))
                    return
                }

                completion(Result.success(decodedData))
            }

            dataTask.resume()
        }

    func getCityCoordinates(city: String, completion: @escaping (CLLocationCoordinate2D) -> Void) {
        let city = city.capitalized
        let url = URL(string: "https://api.openweathermap.org/geo/1.0/direct?q=\(city)&appid=5794a90661fd4a193a5a4e22da9f6945")!

        getJSONData(as: CityCoordinatesModel.self, from: url) { cityCoordinates in
            switch cityCoordinates {
            case .success(let cityCoordinates):
                guard let cityCoordinates = cityCoordinates.first else { return }
                let coordinates = CLLocationCoordinate2D(latitude: cityCoordinates.lat, longitude: cityCoordinates.lon)
                completion(coordinates)
            case .failure:
                break
            }

        }
    }
}

// MARK: - NetworkError

enum NetworkError: Error {

    case noData
    case corruptedJSON

}
