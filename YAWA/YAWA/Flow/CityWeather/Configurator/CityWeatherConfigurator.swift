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
        let presenter = CityWeatherPresenter()

        view.presenter = presenter
        presenter.view = view

        return view
    }

}
