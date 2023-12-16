//
//  AllCitiesWeatherViewController.swift
//  YAWA
//
//  Created by Bassist Zero on 12/15/23.
//

protocol AllCitiesWeatherViewInput: AnyObject {

    func reloadData()

}

import UIKit

final class AllCitiesWeatherViewController: UIViewController {

    private var tableView = UITableView()
    private var gradientLayer = CAGradientLayer()

    var presenter: AllCitiesWeatherPresenter?
    private let build = ViewService.shared

    private let allCitiesWeatherTableViewAdapter = AllCitiesWeatherTableViewAdapter()

    // MARK: - Life-Cycle

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        presenter?.viewDidLoad()
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        configureBackground()
        configureTableView()
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

    func configure() {
        navigationItem.searchController?.searchBar.delegate = self

        presenter?.adapter = allCitiesWeatherTableViewAdapter

        configureTableView()
        configureBackground()
    }

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
    }

}

// MARK: - AllCitiesWeatherViewInput

extension AllCitiesWeatherViewController: AllCitiesWeatherViewInput {

    func reloadData() {
        tableView.reloadData()
    }

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
