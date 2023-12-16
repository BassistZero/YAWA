//
//  CityWeatherConfigurator.swift
//  YAWA
//
//  Created by Bassist Zero on 12/12/23.
//

import UIKit.UIViewController

struct CityWeatherConfigurator {

    static func configure(with city: String? = nil) -> UIViewController {
        let view = CityWeatherViewController()
        let networkService = NetworkServiceImpl.shared
        let weatherPhotoService = WeatherPhotoService()
        let storageService = StorageService.shared
        let presenter = CityWeatherPresenter()

        view.presenter = presenter

        presenter.view = view
        presenter.networkService = networkService
        presenter.weatherPhotoService = weatherPhotoService
        presenter.storageService = storageService

        guard let city else {
            let locationService = LocationService()
            presenter.locationService = locationService
            return view
        }

        presenter.city = city

        return view
    }

}
