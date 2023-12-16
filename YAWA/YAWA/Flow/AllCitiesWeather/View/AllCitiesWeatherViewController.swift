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

    private var tableView = UITableView()

    var presenter: AllCitiesWeatherPresenter?

    private let allCitiesWeatherTableViewAdapter = AllCitiesWeatherTableViewAdapter()
    private let networkService = NetworkServiceImpl.shared
    private let cities = ["London", "Voronezh", "Miami"]
    private var forecasts = [String: WeatherModel]() {
        didSet {
            allCitiesWeatherTableViewAdapter.forecasts = forecasts
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .primary
        configureTableView()
    }

    func reloadData() {
        tableView.reloadData()
    }

}

// MARK: - Configuration

private extension AllCitiesWeatherViewController {

    func configureTableView() {
        tableView = {
            let tableView = UITableView()
            tableView.translatesAutoresizingMaskIntoConstraints = false

            tableView.register(AllCitiesWeatherTableViewCell.self, forCellReuseIdentifier: "\(AllCitiesWeatherTableViewCell.self)")
            tableView.separatorStyle = .none

            return tableView
        }()

        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        tableView.dataSource = allCitiesWeatherTableViewAdapter
        tableView.delegate = allCitiesWeatherTableViewAdapter
        allCitiesWeatherTableViewAdapter.viewController = self
        allCitiesWeatherTableViewAdapter.cities = cities


        cities.forEach { city in
            networkService.loadCityWeather(city: city) { weather in
                self.forecasts.updateValue(weather, forKey: city)

                DispatchQueue.main.async {
                    self.reloadData()
                }
            }
        }
    }

}

// MARK: - AllCitiesWeatherViewInput

extension AllCitiesWeatherViewController: AllCitiesWeatherViewInput {

}
