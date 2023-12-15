//
//  CityWeatherConfigurator.swift
//  YAWA
//
//  Created by Bassist Zero on 12/12/23.
//

import UIKit.UIViewController

struct CityWeatherConfigurator {

    static func configure() -> UIViewController {
        let view = CityWeatherViewController()
        let networkService = NetworkServiceImpl.shared
        let weatherPhotoService = WeatherPhotoService()

        let presenter = CityWeatherPresenter(view: view, networkService: networkService, weatherPhotoService: weatherPhotoService)

        view.presenter = presenter

        return view
    }

}
