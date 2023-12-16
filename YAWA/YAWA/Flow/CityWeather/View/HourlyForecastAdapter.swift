//
//  HourlyForecastAdapter.swift
//  YAWA
//
//  Created by Bassist Zero on 12/14/23.
//

import UIKit

protocol HourlyForecastAdapterDelegate: AnyObject { }

final class HourlyForecastAdapter: NSObject {

    var forecast: HourlyForecastModel?
    private let weatherPhotoService = WeatherPhotoService()

    weak var delegate: HourlyForecastAdapterDelegate?

}

extension HourlyForecastAdapter: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        forecast?.list.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(CityWeatherHourlyForecastCell.self)", for: indexPath) as? CityWeatherHourlyForecastCell, let forecast else {
            return .init()
        }

        let weatherID = forecast.list[indexPath.row].weather.first?.id

        let temperature = forecast.list[indexPath.row].main.temp

        // "2022-08-30 17:00:00". Drop 8 means get time only
        let timeIndex = 8

        let timeRaw = String(forecast.list[indexPath.row].dtTxt.suffix(timeIndex))

        let stringToDateFormatter = DateFormatter()
        stringToDateFormatter.dateFormat = "HH:mm:ss"

        let timeDate = stringToDateFormatter.date(from: timeRaw)!

        let dateToStringFormatter = DateFormatter()
        dateToStringFormatter.dateFormat = "H"
        dateToStringFormatter.locale = .autoupdatingCurrent

        let timeString = dateToStringFormatter.string(from: timeDate)

        cell.temperature = temperature
        cell.time = timeString

        weatherPhotoService.getPhoto(from: weatherID) { weatherConditionImage in
            DispatchQueue.main.async {
                cell.weatherConditionImage = weatherConditionImage
            }
        }

        return cell
    }

}

extension HourlyForecastAdapter: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        print("pressed")
    }

}

extension HourlyForecastAdapter: UICollectionViewDelegateFlowLayout {

}
