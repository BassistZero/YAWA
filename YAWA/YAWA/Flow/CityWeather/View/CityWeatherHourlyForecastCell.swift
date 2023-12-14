//
//  CityWeatherHourlyForecastCell.swift
//  YAWA
//
//  Created by Bassist Zero on 12/13/23.
//

import UIKit

final class CityWeatherHourlyForecastCell: UICollectionViewCell {

    private lazy var timeLabel = UILabel()
    private lazy var temperatureLabel = UILabel()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: - Configuration

    func configure(time: String, temperature: Int) {
        timeLabel.text = time
        temperatureLabel.text = "\(temperature)º"
    }

}

// MARK: - Configuration

private extension CityWeatherHourlyForecastCell {

    func setupUI() {
        timeLabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false

            label.textColor = .white
            label.font = .systemFont(ofSize: 16, weight: .light)

            return label
        }()

        temperatureLabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false

            label.textColor = .white

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
        contentView.addSubview(temperatureLabel)

        NSLayoutConstraint.activate([
            timeLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            timeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            timeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            temperatureLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: Constraint.spacer),
            temperatureLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constraint.leading),
            temperatureLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Constraint.trailing),
            temperatureLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: Constraint.bottom)
        ])
    }

}

// MARK: - Constants

private extension CityWeatherHourlyForecastCell {

    enum Constraint {
        static let leading: CGFloat = 8
        static let top: CGFloat = 8
        static let trailing: CGFloat = -8
        static let bottom: CGFloat = -8
        static let spacer: CGFloat = 8
    }

}
