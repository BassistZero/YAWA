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

    typealias SummaryForecastData = (forecast: WeatherModel, weatherConditionImage: UIImage)
    typealias HourlyForecastData = HourlyForecastModel

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

    private var summaryForecastData: SummaryForecastData? {
        didSet {
            DispatchQueue.main.async {
                self.view?.showSummary(forecast: self.summaryForecastData?.forecast, weatherConditionImage: self.summaryForecastData?.weatherConditionImage)
            }
        }
    }
    private var hourlyForecastData: HourlyForecastData? {
        didSet {
            DispatchQueue.main.asyncAndWait {
                self.view?.showHourlyForecast(forecast: self.hourlyForecastData)
            }
        }
    }


    func getCity(completion: (() -> Void)? = nil) {
        view?.showSummary(forecast: summaryForecastData?.forecast, weatherConditionImage: summaryForecastData?.weatherConditionImage)

        self.locationService.requestPermission()

        DispatchQueue.global(qos: .background).async {
            completion?()
        }

    }

    func getBackground() {
        view?.showBackground()
    }

    func getForecast(completion: (() -> Void)? = nil) {
        view?.showHourlyForecast(forecast: hourlyForecastData)

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
                    self.summaryForecastData = (weather, weatherConditionImage)
                }
            }
        }
    }

    func getForecastWeather() {
        getForecast {
            self.locationService.getCurrentLocation { location in
                self.networkService.loadCurrentForecast(location: location) { forecast in
                    self.hourlyForecastData = forecast
                }
            }
        }
    }

}
