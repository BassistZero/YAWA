//
//  AllCitiesWeatherPresenter.swift
//  YAWA
//
//  Created by Bassist Zero on 12/15/23.
//

import Foundation

final class AllCitiesWeatherPresenter {

    weak var view: AllCitiesWeatherViewInput?
    weak var adapter: AllCitiesWeatherTableViewAdapter?

    private let storageService = StorageService.shared
    private let networkService = NetworkServiceImpl.shared

    private var cities = [String]() {
        didSet {
            adapter?.cities = cities
            getWeatherData()
            view?.reloadData()
        }
    }

    private var forecasts = [String: WeatherModel]() {
        didSet {
            adapter?.forecasts = forecasts
        }
    }

    func viewDidLoad() {
        storageService.delegate = self
        updateCities()
        adapter?.cities = cities
        view?.reloadData()
    }

    func updateCities() {
        cities = storageService.loadCities()
    }

    func getWeatherData() {
        cities.forEach { city in
            networkService.loadCityWeather(city: city) { weather in
                self.forecasts.updateValue(weather, forKey: city)

                DispatchQueue.main.async {
                    self.view?.reloadData()
                }
            }
        }
    }

}

// MARK: - StorageServiceDelegate

extension AllCitiesWeatherPresenter: StorageServiceDelegate {

    func storageUpdated() {
        updateCities()
    }
    
}
