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
    private var gradientLayer = CAGradientLayer()

    var presenter: AllCitiesWeatherPresenter?
    private let build = ViewService.shared

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

        navigationItem.searchController?.searchBar.delegate = self

        configureTableView()
        configureBackground()
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        configureBackground()
        configureTableView()
    }

    func reloadData() {
        tableView.reloadData()
    }

    func configureBackground() {
        let oldLayer = gradientLayer
        gradientLayer = build.createBackgroundGradient()

        view.layer.insertSublayer(gradientLayer, at: 0)
        oldLayer.removeFromSuperlayer()
    }

}

// MARK: - Configuration

private extension AllCitiesWeatherViewController {

    func configureTableView() {
        let oldView = tableView
        tableView = {
            let tableView = UITableView()
            tableView.translatesAutoresizingMaskIntoConstraints = false

            tableView.register(AllCitiesWeatherTableViewCell.self, forCellReuseIdentifier: "\(AllCitiesWeatherTableViewCell.self)")
            tableView.separatorStyle = .none
            tableView.backgroundColor = .clear

            return tableView
        }()

        view.addSubview(tableView)
        oldView.removeFromSuperview()

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

extension AllCitiesWeatherViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }

        let vc = CityWeatherConfigurator.configure(with: text)
        present(vc, animated: true)

        searchBar.text = ""
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // FIXME: - Networking autocomplete
    }

}
