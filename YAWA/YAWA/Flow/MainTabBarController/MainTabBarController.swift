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

        viewControllers = [WeatherViewController()]
    }
    
}
