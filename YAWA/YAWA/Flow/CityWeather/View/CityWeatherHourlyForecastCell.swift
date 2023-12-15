//
//  CityWeatherHourlyForecastCell.swift
//  YAWA
//
//  Created by Bassist Zero on 12/13/23.
//

import UIKit

final class CityWeatherHourlyForecastCell: UICollectionViewCell {

    private lazy var timeLabel = UILabel()
    private lazy var weatherConditionImageView = UIImageView()
    private lazy var temperatureLabel = UILabel()

    var time: String? {
        didSet {
            guard let time else { return }
            timeLabel.text = time
        }
    }

    var weatherConditionImage: UIImage? {
        didSet {
            guard let weatherConditionImage else { return }
            weatherConditionImageView.image = weatherConditionImage
        }
    }

    var temperature: Double? {
        didSet {
            guard let temperature else { return }
            temperatureLabel.text = "\(String(format: "%.1f", temperature))º"
        }
    }

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}

// MARK: - Configuration

private extension CityWeatherHourlyForecastCell {

    func setupUI() {
        timeLabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false

            label.textColor = .textColor
            label.font = UIFont.systemFont(ofSize: 16, weight: .light)
            label.textAlignment = .center

            return label
        }()

        weatherConditionImageView = {
            let imageView = UIImageView()
            imageView.translatesAutoresizingMaskIntoConstraints = false

            imageView.tintColor = .white
            imageView.contentMode = .scaleAspectFit

            imageView.layer.shadowOffset = .init(width: 3, height: 3)
            imageView.layer.shadowOpacity = 0.3
            imageView.layer.shadowColor = UIColor.systemBlack.cgColor
            imageView.layer.shadowRadius = 7

            return imageView
        }()

        temperatureLabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false

            label.textColor = .textColor
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 16, weight: .light)
            label.lineBreakMode = .byClipping

            return label
        }()

        contentView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: self.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])

        contentView.addSubview(timeLabel)
        contentView.addSubview(weatherConditionImageView)
        contentView.addSubview(temperatureLabel)

        NSLayoutConstraint.activate([
            timeLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            timeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            timeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            weatherConditionImageView.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: Constraint.spacer),
            weatherConditionImageView.heightAnchor.constraint(equalToConstant: 36),
            weatherConditionImageView.widthAnchor.constraint(equalTo: weatherConditionImageView.heightAnchor),
            weatherConditionImageView.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor),
            weatherConditionImageView.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor),
            weatherConditionImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),

            temperatureLabel.topAnchor.constraint(equalTo: weatherConditionImageView.bottomAnchor, constant: Constraint.spacer),
            temperatureLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            temperatureLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            temperatureLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

}

// MARK: - Constants

private extension CityWeatherHourlyForecastCell {

    enum Constraint {
        static let spacer: CGFloat = 8
    }

}
