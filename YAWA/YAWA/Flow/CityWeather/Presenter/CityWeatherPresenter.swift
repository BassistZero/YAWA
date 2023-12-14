//
//  CityWeatherPresenter.swift
//  YAWA
//
//  Created by Bassist Zero on 12/12/23.
//

import UIKit.UIViewController

final class CityWeatherPresenter {


    weak var view: CityWeatherViewInput?

    func getCity() {
        let city = "Paris"
        view?.showSummary(for: city)
    }

    func getBackground() {
        view?.showBackground()
    }

    func getForecast() {

        view?.showHourlyForecast(forecast: nil)


    }

}
