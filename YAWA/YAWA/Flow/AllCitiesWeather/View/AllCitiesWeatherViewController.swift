//
//  AllCitiesWeatherViewController.swift
//  YAWA
//
//  Created by Bassist Zero on 12/15/23.
//

protocol AllCitiesWeatherViewInput: AnyObject {
    
}

import UIKit

final class AllCitiesWeatherViewController: UIViewController {

    var presenter: AllCitiesWeatherPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemRed
    }

}

// MARK: - AllCitiesWeatherViewInput

extension AllCitiesWeatherViewController: AllCitiesWeatherViewInput {

}
