//
//  AllCitiesWeatherTableViewAdapter.swift
//  YAWA
//
//  Created by Bassist Zero on 12/15/23.
//

import UIKit

final class AllCitiesWeatherTableViewAdapter: NSObject {

    weak var viewController: UIViewController?
    var forecasts: [String: WeatherModel]?
    var cities: [String]?
    private let weatherPhotoService = WeatherPhotoService()

}

// MARK: - UITableViewDataSource

extension AllCitiesWeatherTableViewAdapter: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cities?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(AllCitiesWeatherTableViewCell.self)", for: indexPath) as? AllCitiesWeatherTableViewCell, let cities else { return .init() }

        var weatherID: Int?
        let temperatureRange: String
        let currentTemperature: String

        if let forecasts, let forecast = forecasts[cities[indexPath.row]] {
            temperatureRange = "\(forecast.main.tempMin)º — \(forecast.main.tempMax)º"
            currentTemperature = "\(String(format: "%.1f", forecast.main.temp))º"
            weatherID = forecast.weather.first?.id
        }
        else {
            temperatureRange = "-º — -º"
            currentTemperature = "—"
        }

        cell.cityName = cities[indexPath.row]
        cell.temperatureCurrent = currentTemperature
        cell.temperatureRange = temperatureRange
        cell.weatherConditionImage = weatherPhotoService.getNativePhoto(from: weatherID)

        return cell
    }

}

// MARK: - UITableViewDelegate

extension AllCitiesWeatherTableViewAdapter: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cities else { return }
        let city = cities[indexPath.row]
        let vc = CityWeatherConfigurator.configure(with: city)
        viewController?.present(vc, animated: true)
    }

}
