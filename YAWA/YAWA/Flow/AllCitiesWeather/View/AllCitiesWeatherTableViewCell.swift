//
//  AllCitiesWeatherTableViewCell.swift
//  YAWA
//
//  Created by Bassist Zero on 12/15/23.
//

import UIKit

final class AllCitiesWeatherTableViewCell: UITableViewCell {

    private var spacedContentView = UIView()
    private var cityNameLabel = UILabel()
    private var weatherConditionImageView = UIImageView()
    private var temperatureCurrentLabel = UILabel()
    private var temperatureRangeLabel = UILabel()
    private let build = ViewService.shared

    var cityName: String? {
        didSet {
            cityNameLabel.text = cityName
        }
    }

    var weatherConditionImage: UIImage? {
        didSet {
            weatherConditionImageView.image = weatherConditionImage
        }
    }

    var temperatureCurrent: String? {
        didSet {
            temperatureCurrentLabel.text = temperatureCurrent
        }
    }

    var temperatureRange: String? {
        didSet {
            temperatureRangeLabel.text = temperatureRange
        }
    }

    // MARK: - Inits

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        configureLabels()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK: - Configuration

private extension AllCitiesWeatherTableViewCell {

    func configureLabels() {
        spacedContentView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false

            let gradientLayer = build.createGradientLayer(colors: UIColor.gradientBackground, frame: CGRect(x: 0, y: 0, width: 500, height: 300))
            gradientLayer.startPoint = CGPoint(x: 0, y: 0)
            view.layer.addSublayer(gradientLayer)

            view.layer.cornerRadius = 15
            view.layer.cornerCurve = .continuous

            view.layer.borderColor = UIColor.white.cgColor
            view.layer.borderWidth = 2

            view.clipsToBounds = true

            return view
        }()

        cityNameLabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false

            label.textColor = .textColor
            label.font = UIFont.systemFont(ofSize: 24, weight: .bold)

            return label
        }()

        weatherConditionImageView = {
            let imageView = UIImageView()
            imageView.translatesAutoresizingMaskIntoConstraints = false

            imageView.contentMode = .scaleAspectFit
            imageView.tintColor = .white

            imageView.layer.shadowOffset = .init(width: 3, height: 3)
            imageView.layer.shadowOpacity = 0.3
            imageView.layer.shadowColor = UIColor.systemBlack.cgColor
            imageView.layer.shadowRadius = 7

            return imageView
        }()

        temperatureCurrentLabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false

            label.textColor = .textColor
            label.font = UIFont.systemFont(ofSize: 32, weight: .semibold)

            return label
        }()

        temperatureRangeLabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false

            label.textColor = .textColor
            label.font = UIFont.systemFont(ofSize: 14, weight: .regular)

            return label
        }()

        if let superview = contentView.superview {
            superview.backgroundColor = .clear
        }

        contentView.addSubview(spacedContentView)

        spacedContentView.addSubview(cityNameLabel)
        spacedContentView.addSubview(weatherConditionImageView)
        spacedContentView.addSubview(temperatureCurrentLabel)
        spacedContentView.addSubview(temperatureRangeLabel)

        NSLayoutConstraint.activate([
            spacedContentView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            spacedContentView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            spacedContentView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            spacedContentView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),

            cityNameLabel.topAnchor.constraint(equalTo: spacedContentView.topAnchor, constant: 8),
            cityNameLabel.leadingAnchor.constraint(equalTo: spacedContentView.leadingAnchor, constant: 8),
            cityNameLabel.bottomAnchor.constraint(equalTo: spacedContentView.bottomAnchor, constant: -8),

            temperatureCurrentLabel.topAnchor.constraint(equalTo: spacedContentView.topAnchor, constant: 8),
            temperatureCurrentLabel.trailingAnchor.constraint(equalTo: spacedContentView.trailingAnchor, constant: -8),

            temperatureRangeLabel.topAnchor.constraint(equalTo: temperatureCurrentLabel.bottomAnchor, constant: 16),
            temperatureRangeLabel.bottomAnchor.constraint(equalTo: spacedContentView.bottomAnchor, constant: -8),
            temperatureRangeLabel.trailingAnchor.constraint(equalTo: spacedContentView.trailingAnchor, constant: -8),

            weatherConditionImageView.centerYAnchor.constraint(equalTo: spacedContentView.centerYAnchor),
            weatherConditionImageView.leadingAnchor.constraint(greaterThanOrEqualTo: cityNameLabel.trailingAnchor, constant: 16),
            weatherConditionImageView.trailingAnchor.constraint(equalTo: temperatureRangeLabel.leadingAnchor, constant: -16),
            weatherConditionImageView.topAnchor.constraint(equalTo: spacedContentView.topAnchor, constant: 8),
            weatherConditionImageView.bottomAnchor.constraint(equalTo: spacedContentView.bottomAnchor, constant: -8),
            weatherConditionImageView.widthAnchor.constraint(equalTo: weatherConditionImageView.heightAnchor)
        ])
    }

}
