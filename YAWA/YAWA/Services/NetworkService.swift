//
//  NetworkService.swift
//  YAWA
//
//  Created by Bassist Zero on 12/13/23.
//

import Foundation
import CoreLocation.CLLocation
import UIKit.UIImage

protocol NetworkService {
    func loadCurrentWeather(completion: @escaping (WeatherModel) -> Void)
    func loadCurrentForecast(completion: @escaping (HourlyForecastModel) -> Void)

    func downloadWeatherConditionImage(from url: URL, completion: @escaping (UIImage) -> Void)
}

final class NetworkServiceImpl:NetworkService {

    static var shared = NetworkServiceImpl()
    private init() { }

    private let appid = "5794a90661fd4a193a5a4e22da9f6945"
    private let lat = 49.263625
    private let lon = -123.138589

    func loadCurrentForecast(completion: @escaping (HourlyForecastModel) -> Void) {
        let url = URL(string: "https://api.openweathermap.org/data/2.5/forecast/?lat=\(lat)&lon=\(lon)&exclude=current,minutely,alerts&units=metric&cnt=9&appid=\(appid)")!

        let request = URLRequest(url: url)
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase

            let weather = try! jsonDecoder.decode(HourlyForecastModel.self, from: data!)
            completion(weather)
        }

        dataTask.resume()
    }
    


    func loadCurrentWeather(completion: @escaping (WeatherModel) -> Void) {


        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&exclude=current,minutely,hourly,alerts&units=metric&appid=\(appid)")!

        let request = URLRequest(url: url)

        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase

            let weather = try! jsonDecoder.decode(WeatherModel.self, from: data!)

            completion(weather)
        }

        dataTask.resume()
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
