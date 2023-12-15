//
//  CityWeatherPresenter.swift
//  YAWA
//
//  Created by Bassist Zero on 12/12/23.
//

import UIKit.UIViewController

protocol CityWeatherPresenterDelegate: AnyObject {
    func getCityWeather()
    func getForecastWeather()
}

final class CityWeatherPresenter {

    init(view: CityWeatherViewInput, networkService: NetworkService, weatherPhotoService: WeatherPhotoService, locationService: LocationService) {
        self.view = view
        self.networkService = networkService
        self.weatherPhotoService = weatherPhotoService
        self.locationService = locationService

        locationService.presenter = self
    }

    weak var view: CityWeatherViewInput?
    private let networkService: NetworkService
    private let weatherPhotoService: WeatherPhotoService
    private let locationService: LocationService


    func getCity(completion: (() -> Void)? = nil) {
        view?.showSummary(forecast: nil, weatherConditionImage: nil)

        self.locationService.requestPermission()

        DispatchQueue.global(qos: .background).async {
            completion?()
        }

    }

    func getBackground() {
        view?.showBackground()
    }

    func getForecast(completion: (() -> Void)? = nil) {
        view?.showHourlyForecast(forecast: nil)

        DispatchQueue.global(qos: .background).async {
            completion?()
        }

    }

}

// MARK: - CityWeatherPresenterDelegate

extension CityWeatherPresenter: CityWeatherPresenterDelegate {

    func getCityWeather() {
        getCity {
            self.locationService.getCurrentLocation { location in
                self.networkService.loadCurrentWeather(location: location) { weather in
                    let weatherConditionImage = self.weatherPhotoService.getNativePhoto(from: weather.weather[0].id)
                    DispatchQueue.main.async {
                        self.view?.showSummary(forecast: weather, weatherConditionImage: weatherConditionImage)
                    }
                }
            }
        }
    }

    func getForecastWeather() {
        getForecast {
            self.locationService.getCurrentLocation { location in
                self.networkService.loadCurrentForecast(location: location) { forecast in
                    DispatchQueue.main.async {
                        self.view?.showHourlyForecast(forecast: forecast)
                    }
                }
            }
        }
    }

}
