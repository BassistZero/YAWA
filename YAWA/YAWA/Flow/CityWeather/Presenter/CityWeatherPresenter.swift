//
//  CityWeatherPresenter.swift
//  YAWA
//
//  Created by Bassist Zero on 12/12/23.
//

import UIKit.UIViewController

protocol CityWeatherPresenterDelegate: AnyObject {
    func getLocationWeather()
}

final class CityWeatherPresenter {

    typealias SummaryForecastData = (forecast: WeatherModel, weatherConditionImage: UIImage)
    typealias HourlyForecastData = HourlyForecastModel

    weak var view: CityWeatherViewInput?
    var networkService: NetworkService?
    var weatherPhotoService: WeatherPhotoService?
    var locationService: LocationService?

    var city: String?

    private var summaryForecastData: SummaryForecastData? {
        didSet {
            DispatchQueue.main.async {
                self.view?.showSummary(forecast: self.summaryForecastData?.forecast, weatherConditionImage: self.summaryForecastData?.weatherConditionImage)
            }
        }
    }
    private var hourlyForecastData: HourlyForecastData? {
        didSet {
            DispatchQueue.main.async {
                self.view?.showHourlyForecast(forecast: self.hourlyForecastData)
            }
        }
    }

    func requestWeather() {
        guard let city else {
            locationService?.presenter = self
            locationService?.requestLocationWeather()
            return
        }

        requestWeather(for: city)
    }

    func getViews(completion: (() -> Void)? = nil) {
        view?.showBackground()
        view?.showSummary(forecast: summaryForecastData?.forecast, weatherConditionImage: summaryForecastData?.weatherConditionImage)
        view?.showHourlyForecast(forecast: hourlyForecastData)

        self.locationService?.requestPermission()

        DispatchQueue.global(qos: .background).async {
            completion?()
        }

    }

}

// MARK: - CityWeatherPresenterDelegate

extension CityWeatherPresenter: CityWeatherPresenterDelegate {

    func getLocationWeather() {
        getViews {
            self.locationService?.getCurrentLocation { location in
                self.networkService?.loadCurrentWeather(location: location) { weather in
                    self.networkService?.loadCurrentForecast(location: location) { forecast in
                        guard let weatherConditionImage = self.weatherPhotoService?.getNativePhoto(from: weather.weather.first?.id) else { return }
                        self.summaryForecastData = (weather, weatherConditionImage)
                        self.hourlyForecastData = forecast
                    }
                }
            }
        }
    }

}

private extension CityWeatherPresenter {

    func requestWeather(for city: String) {
        DispatchQueue.global(qos: .background).async {
            self.networkService?.loadCityForecast(city: city) { forecast in
                self.networkService?.loadCityWeather(city: city) { weather in
                    guard let weatherConditionImage = self.weatherPhotoService?.getNativePhoto(from: weather.weather.first?.id) else { return }
                    DispatchQueue.main.async {
                        self.summaryForecastData = (weather, weatherConditionImage)
                        self.hourlyForecastData = forecast
                    }
                }
            }
        }
    }

}
