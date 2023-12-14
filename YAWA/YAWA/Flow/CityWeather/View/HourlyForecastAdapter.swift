//
//  HourlyForecastAdapter.swift
//  YAWA
//
//  Created by Bassist Zero on 12/14/23.
//

import UIKit

protocol HourlyForecastAdapterDelegate: AnyObject { }

final class HourlyForecastAdapter: NSObject {

    var forecast: [(time: String, temperature: Int)]?

    weak var delegate: HourlyForecastAdapterDelegate?

}

extension HourlyForecastAdapter: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        forecast?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(CityWeatherHourlyForecastCell.self)", for: indexPath) as? CityWeatherHourlyForecastCell, let forecast else {
            return .init()
        }

        let (time, temperature) = forecast[indexPath.row]

        cell.configure(time: time, temperature: temperature)

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
