//
//  AllCitiesWeatherConfigurator.swift
//  YAWA
//
//  Created by Bassist Zero on 12/15/23.
//

import UIKit.UIViewController

struct AllCitiesWeatherConfigurator {

    static func configure() -> UIViewController {
        let view = AllCitiesWeatherViewController()
        let presenter = AllCitiesWeatherPresenter()

        view.presenter = presenter
        presenter.view = view

        return view
    }

}
