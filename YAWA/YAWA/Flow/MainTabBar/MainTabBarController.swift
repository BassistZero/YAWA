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

        let allCitiesWeatherModule = AllCitiesWeatherConfigurator.configure()
        let allCitiesWeatherModuleWrapper = UINavigationController(rootViewController: allCitiesWeatherModule)

        allCitiesWeatherModule.title = "Cities"
        allCitiesWeatherModule.tabBarItem.title = "Cities"
        allCitiesWeatherModule.tabBarItem.image = UIImage(systemName: "building.2.fill")

        allCitiesWeatherModuleWrapper.navigationBar.tintColor = .textColor
        allCitiesWeatherModuleWrapper.navigationBar.prefersLargeTitles = true

        let searchController = UISearchController(searchResultsController: nil)
        allCitiesWeatherModule.navigationItem.searchController = searchController
        allCitiesWeatherModule.navigationItem.hidesSearchBarWhenScrolling = false

        viewControllers = [cityWeatherModule, allCitiesWeatherModuleWrapper]
    }

}
