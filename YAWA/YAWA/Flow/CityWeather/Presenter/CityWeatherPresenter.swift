//
//  CityWeatherPresenter.swift
//  YAWA
//
//  Created by Bassist Zero on 12/12/23.
//

import UIKit.UIViewController

final class CityWeatherPresenter {

    init(view: CityWeatherViewInput, networkService: NetworkService, weatherPhotoService: WeatherPhotoService) {
        self.view = view
        self.networkService = networkService
        self.weatherPhotoService = weatherPhotoService
    }

    weak var view: CityWeatherViewInput?
    private let networkService: NetworkService
    private let weatherPhotoService: WeatherPhotoService

    func getCity() {

        view?.showSummary(forecast: nil, weatherConditionImage: nil)

        networkService.loadCurrentWeather { weather in
            let weatherConditionImage = self.weatherPhotoService.getNativePhoto(from: weather.weather[0].id)
            DispatchQueue.main.async {
                self.view?.showSummary(forecast: weather, weatherConditionImage: weatherConditionImage)
            }
        }
    }

    func getBackground() {
        view?.showBackground()
    }

    func getForecast() {
        view?.showHourlyForecast(forecast: nil)

        networkService.loadCurrentForecast { forecast in
            DispatchQueue.main.async {
                self.view?.showHourlyForecast(forecast: forecast)
            }
        }

    }

}
