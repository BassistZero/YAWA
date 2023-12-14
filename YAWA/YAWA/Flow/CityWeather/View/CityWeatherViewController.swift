//
//  CityWeatherViewController.swift
//  YAWA
//
//  Created by Bassist Zero on 11/21/23.
//

import UIKit

protocol CityWeatherViewInput: AnyObject {

    func showSummary(for city: String)
    func showBackground()
    func showHourlyForecast(forecast: [(time: String, temperature: Int)]?)

}

final class CityWeatherViewController: UIViewController {

    private var scrollView = UIScrollView()
    private var contentView = UIView()
    private var summaryView = UIView()
    private var hourlyForecastView = UIView()
    private var hourlyForecastCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

    private let hourlyForecastAdapter = HourlyForecastAdapter()
    private let scrollViewAdapter = ScrollViewAdapter()

    private let build = ViewService.shared
    var presenter: CityWeatherPresenter?

}

// MARK: - Life-Cycle

extension CityWeatherViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        hourlyForecastAdapter.delegate = self
        presenter?.getBackground()
        configureScrollView()
        presenter?.getCity()
        presenter?.getForecast()
    }

}

// MARK: - HourlyForecastAdapterDelegate

extension CityWeatherViewController: HourlyForecastAdapterDelegate { }

// MARK: - CityWeatherViewInput

extension CityWeatherViewController: CityWeatherViewInput {

    func showSummary(for city: String) {
        summaryView = build.createSummaryView(cityName: city, weatherConditionImage: UIImage(systemName: "sun.max.fill")!, weatherConditionDescription: "Sunny", temperatureRange: (-18)...(-14))
        contentView.addSubview(summaryView)

        NSLayoutConstraint.activate([
            summaryView.topAnchor.constraint(equalTo: contentView.topAnchor),
            summaryView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            summaryView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
        ])
    }

    func showBackground() {
        view.layer.addSublayer(build.createBackgroundGradient())
    }

    func showHourlyForecast(forecast: [(time: String, temperature: Int)]?) {
        hourlyForecastAdapter.forecast = forecast
        hourlyForecastCollectionView = build.createHourlyForecastCollectionView(delegate: hourlyForecastAdapter, dataSource: hourlyForecastAdapter)
        hourlyForecastView = build.createHourlyForecastView(collectionView: hourlyForecastCollectionView)
        contentView.addSubview(hourlyForecastView)

        NSLayoutConstraint.activate([
            hourlyForecastView.topAnchor.constraint(equalTo: summaryView.bottomAnchor, constant: 16),
            hourlyForecastView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            hourlyForecastView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            hourlyForecastView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

}

// FIXME: - Configuration (that definitely shouldn't be here...)

private extension CityWeatherViewController {

    func configureScrollView() {
        scrollView = build.createScrollView()
        view.addSubview(scrollView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        contentView = build.createContentView()
        scrollView.addSubview(contentView)

        let contentViewHeightConstraint = contentView.heightAnchor.constraint(equalTo: scrollView.contentLayoutGuide.heightAnchor)

        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),

            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentViewHeightConstraint
        ])
    }

}
