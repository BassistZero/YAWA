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
        cityWeatherModule.tabBarItem.title = "Current"
        cityWeatherModule.tabBarItem.image = UIImage(systemName: "mappin.and.ellipse")


        let allCitiesWeatherModule = UINavigationController(rootViewController: AllCitiesWeatherConfigurator.configure())
        allCitiesWeatherModule.title = "Cities"
        allCitiesWeatherModule.tabBarItem.title = "Cities"
        allCitiesWeatherModule.tabBarItem.image = UIImage(systemName: "building.2.fill")

        viewControllers = [allCitiesWeatherModule, cityWeatherModule]
    }
    
}
