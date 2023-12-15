//
//  MainTabBarController.swift
//  YAWA
//
//  Created by Bassist Zero on 11/21/23.
//

import UIKit

final class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        tabBar.backgroundColor = .systemWhite
        tabBar.tintColor = .systemBlack

        let cityWeatherModule = CityWeatherConfigurator.configure()
        cityWeatherModule.tabBarItem.title = "Detailed"
        cityWeatherModule.tabBarItem.image = UIImage(systemName: "house.fill")

        let allCitiesWeatherModule = AllCitiesWeatherConfigurator.configure()
        allCitiesWeatherModule.tabBarItem.title = "All"
        allCitiesWeatherModule.tabBarItem.image = UIImage(systemName: "list.bullet")

        viewControllers = [cityWeatherModule, allCitiesWeatherModule]
    }
    
}
