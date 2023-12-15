//
//  ViewBuilder.swift
//  YAWA
//
//  Created by Bassist Zero on 12/12/23.
//

import UIKit

final class ViewService {

    static let shared = ViewService()

    private init() { }

    func createBackgroundGradient() -> CAGradientLayer {
        let frame = UIScreen.main.bounds
        return createGradientLayer(colors: [UIColor(hex: "#2F5AF4")!, UIColor(hex: "#0FA2AB")!], frame: frame)
    }

    func createScrollView() -> UIScrollView {
        lazy var scrollView: UIScrollView = {
            let scrollView = UIScrollView()
            scrollView.translatesAutoresizingMaskIntoConstraints = false

            scrollView.bounces = true
            scrollView.alwaysBounceVertical = true
            
            scrollView.showsVerticalScrollIndicator = false
            scrollView.showsHorizontalScrollIndicator = false

            return scrollView
        }()
        
        return scrollView
    }

    func createContentView() -> UIView {
        lazy var contentView: UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false

            return view
        }()

        return contentView
    }

    func createSummaryView(forecast: WeatherModel? = nil, weatherConditionImage: UIImage? = nil) -> UIView {
        let cityName: String
        let weatherConditionDescription: String
        let humidity: String
        let temperatureRange: String
        let currentTemperature: String

        if let forecast {
            cityName = forecast.name
            weatherConditionDescription = forecast.weather[0].description
            humidity = "Humidity: \(forecast.main.humidity)%"
            temperatureRange = "\(forecast.main.tempMin)º — \(forecast.main.tempMax)º"
            currentTemperature = "\(String(format: "%.1f", forecast.main.temp))º"
        }
        else {
            cityName = "—"
            weatherConditionDescription = "—"
            humidity = "Humidity: —%"
            temperatureRange = "-º — -º"
            currentTemperature = "—"
        }

        lazy var contentView: UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false

            let gradientLayer = createGradientLayer(colors: [UIColor(hex: "#0FA2AB")!, UIColor(hex: "#2F5AF4")!], frame: CGRect(x: 0, y: 0, width: 700, height: 700))
            gradientLayer.startPoint = CGPoint(x: 0, y: 0)

            view.layer.addSublayer(gradientLayer)

            view.layer.borderWidth = 2
            view.layer.borderColor = UIColor.white.cgColor

            view.layer.cornerRadius = 15
            view.layer.cornerCurve = .continuous



            view.clipsToBounds = true

            return view
        }()

        lazy var cityLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false

            label.text = cityName
            label.textColor = .white
            label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)

            return label
        }()

        lazy var timeLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false

            let date = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.timeStyle = .short

            label.text = dateFormatter.string(from: date)
            label.textColor = .white
            label.font = UIFont.systemFont(ofSize: 18, weight: .regular)

            return label
        }()

        lazy var weatherConditionImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.translatesAutoresizingMaskIntoConstraints = false

            imageView.image = weatherConditionImage
            imageView.tintColor = .white
            imageView.contentMode = .scaleAspectFit

            return imageView
        }()

        lazy var weatherConditionDescriptionLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false

            label.text = weatherConditionDescription
            label.textColor = .white
            label.font = UIFont.systemFont(ofSize: 18, weight: .regular)

            return label
        }()

        lazy var currentTemperatureLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false

            label.text = currentTemperature
            label.textColor = .white
            label.font = UIFont.systemFont(ofSize: 32, weight: .bold)

            return label
        }()

        lazy var humidityLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false

            label.text = humidity
            label.textColor = .white
            label.font = UIFont.systemFont(ofSize: 18, weight: .regular)

            return label
        }()

        lazy var temperatureRangeLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false

            label.text = temperatureRange
            label.textColor = .white
            label.font = UIFont.systemFont(ofSize: 18, weight: .regular)

            return label
        }()

        contentView.addSubview(cityLabel)
        contentView.addSubview(timeLabel)
        contentView.addSubview(weatherConditionImageView)
        contentView.addSubview(weatherConditionDescriptionLabel)
        contentView.addSubview(currentTemperatureLabel)
        contentView.addSubview(humidityLabel)
        contentView.addSubview(temperatureRangeLabel)

        NSLayoutConstraint.activate([

            cityLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constraint.top),
            cityLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constraint.leading),

            timeLabel.centerYAnchor.constraint(equalTo: cityLabel.centerYAnchor),
            timeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Constraint.trailing),

            cityLabel.trailingAnchor.constraint(lessThanOrEqualTo: timeLabel.leadingAnchor, constant: Constraint.spacer),
            timeLabel.leadingAnchor.constraint(greaterThanOrEqualTo: cityLabel.trailingAnchor, constant: Constraint.spacer),

            weatherConditionImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            weatherConditionImageView.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 40),
            weatherConditionImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.5),
            weatherConditionImageView.widthAnchor.constraint(equalTo: weatherConditionImageView.heightAnchor),

            weatherConditionDescriptionLabel.topAnchor.constraint(equalTo: weatherConditionImageView.bottomAnchor, constant: Constraint.top),
            weatherConditionDescriptionLabel.centerXAnchor.constraint(equalTo: weatherConditionImageView.centerXAnchor),

            currentTemperatureLabel.centerXAnchor.constraint(equalTo: weatherConditionImageView.centerXAnchor),
            currentTemperatureLabel.topAnchor.constraint(equalTo: weatherConditionDescriptionLabel.bottomAnchor, constant: Constraint.spacer),

            humidityLabel.topAnchor.constraint(equalTo: currentTemperatureLabel.bottomAnchor, constant: Constraint.spacer),
            humidityLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constraint.leading),
            humidityLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: Constraint.bottom),

            temperatureRangeLabel.topAnchor.constraint(equalTo: currentTemperatureLabel.bottomAnchor, constant: Constraint.spacer),
            temperatureRangeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Constraint.trailing),
            temperatureRangeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: Constraint.bottom),

            temperatureRangeLabel.leadingAnchor.constraint(greaterThanOrEqualTo: humidityLabel.trailingAnchor, constant: Constraint.spacer),
            humidityLabel.trailingAnchor.constraint(lessThanOrEqualTo: temperatureRangeLabel.leadingAnchor, constant: Constraint.spacer)
        ])

        return contentView
    }

    func createHourlyForecastCollectionView(delegate: UICollectionViewDelegate, dataSource: UICollectionViewDataSource) -> UICollectionView {
        lazy var collectionView: UICollectionView = {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
            collectionView.translatesAutoresizingMaskIntoConstraints = false

            (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.estimatedItemSize = UICollectionViewFlowLayout.automaticSize

            collectionView.backgroundColor = .clear

            collectionView.contentInset = .init(top: 8, left: Constraint.leading, bottom: 8, right: Constraint.leading)

            collectionView.delegate = delegate
            collectionView.dataSource = dataSource

            collectionView.showsVerticalScrollIndicator = false
            collectionView.showsHorizontalScrollIndicator = false

            collectionView.register(CityWeatherHourlyForecastCell.self, forCellWithReuseIdentifier: "\(CityWeatherHourlyForecastCell.self)")

            return collectionView
        }()

        return collectionView
    }

    func createHourlyForecastView(collectionView: UICollectionView) -> UIView {
        lazy var contentView: UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false

            let gradientLayer = createGradientLayer(colors: [UIColor(hex: "#0FA2AB")!, UIColor(hex: "#2F5AF4")!], frame: CGRect(x: 0, y: 0, width: 500, height: 300))
            gradientLayer.startPoint = CGPoint(x: 0, y: 0)
            view.layer.addSublayer(gradientLayer)


            view.layer.cornerRadius = 15
            view.layer.cornerCurve = .continuous

            view.layer.borderColor = UIColor.white.cgColor
            view.layer.borderWidth = 2

            view.clipsToBounds = true

            return view
        }()

        contentView.addSubview(collectionView)

        let collectionViewHeightConstraint = collectionView.heightAnchor.constraint(equalToConstant: 120)
        collectionViewHeightConstraint.priority = UILayoutPriority(50)

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            collectionViewHeightConstraint
        ])

        return contentView
    }

}

// MARK: - Constants

private extension ViewService {

    enum Constraint {
        static let leading: CGFloat = 20
        static let top: CGFloat = 20
        static let trailing: CGFloat = -20
        static let bottom: CGFloat = -20
        static let spacer: CGFloat = 16
    }

}

// MARK: - Helper Methods

private extension ViewService {

    func createGradientLayer(colors: [UIColor], frame: CGRect) -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()

        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.frame = frame

        return gradientLayer
    }

}
