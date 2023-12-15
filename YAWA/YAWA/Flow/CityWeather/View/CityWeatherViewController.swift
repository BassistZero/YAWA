//
//  CityWeatherViewController.swift
//  YAWA
//
//  Created by Bassist Zero on 11/21/23.
//

import UIKit

protocol CityWeatherViewInput: AnyObject {

    func showSummary(forecast: WeatherModel?, weatherConditionImage: UIImage?)
    func showBackground()
    func showHourlyForecast(forecast: HourlyForecastModel?)

}

final class CityWeatherViewController: UIViewController {

    private var gradientLayer = CAGradientLayer()
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
        presenter?.getBackground()
        presenter?.getCity()
        presenter?.getForecast()

        configure()
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        presenter?.getBackground()
        presenter?.getCity()
        presenter?.getForecast()
    }

}

// MARK: - HourlyForecastAdapterDelegate

extension CityWeatherViewController: HourlyForecastAdapterDelegate { }

// MARK: - CityWeatherViewInput

extension CityWeatherViewController: CityWeatherViewInput {

    func showSummary(forecast: WeatherModel?, weatherConditionImage: UIImage?) {
        configureSummary(forecast: forecast, weatherConditionImage: weatherConditionImage)
    }

    func showBackground() {
        configureBackground()
    }

    func showHourlyForecast(forecast: HourlyForecastModel?) {
        configureHourlyForecast(forecast: forecast)
    }

}

// FIXME: - Configuration (that definitely shouldn't be here...)

private extension CityWeatherViewController {

    func configure() {
        hourlyForecastAdapter.delegate = self
        layout()
    }

    func layout() {
        configureScrollView()

        showSummary(forecast: nil, weatherConditionImage: nil)
        showHourlyForecast(forecast: nil)
    }

    func configureScrollView() {
        scrollView = build.createScrollView(delegate: scrollViewAdapter)
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

    func configureSummary(forecast: WeatherModel?, weatherConditionImage: UIImage?) {
        let oldView = summaryView
        summaryView = build.createSummaryView(forecast: forecast, weatherConditionImage: weatherConditionImage)
        contentView.addSubview(summaryView)
        oldView.removeFromSuperview()

        NSLayoutConstraint.activate([
            summaryView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            summaryView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            summaryView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
        ])
    }

    func configureBackground() {
        let oldLayer = gradientLayer
        gradientLayer = build.createBackgroundGradient()

        view.layer.insertSublayer(gradientLayer, at: 0)
        oldLayer.removeFromSuperlayer()
        print(view.layer.sublayers!.count)
    }

    func configureHourlyForecast(forecast: HourlyForecastModel?) {
        hourlyForecastAdapter.forecast = forecast

        hourlyForecastCollectionView = build.createHourlyForecastCollectionView(delegate: hourlyForecastAdapter, dataSource: hourlyForecastAdapter)

        let oldView = hourlyForecastView
        hourlyForecastView = build.createHourlyForecastView(collectionView: hourlyForecastCollectionView)
        contentView.addSubview(hourlyForecastView)
        oldView.removeFromSuperview()

        NSLayoutConstraint.activate([
            hourlyForecastView.topAnchor.constraint(equalTo: summaryView.bottomAnchor, constant: 16),
            hourlyForecastView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            hourlyForecastView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            hourlyForecastView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

}
