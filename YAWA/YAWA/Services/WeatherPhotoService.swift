//
//  WeatherPhotoService.swift
//  YAWA
//
//  Created by Bassist Zero on 12/14/23.
//

import UIKit

final class WeatherPhotoService {

    private let networkService: NetworkService = NetworkServiceImpl.shared

    func getNativePhoto(from weatherCode: Int) -> UIImage {
        let systemImageName: String

        switch weatherCode {
        case 800:
            systemImageName = "sun.max.fill"
        case 801:
            systemImageName = "cloud.sun.fill"
        case 802:
            systemImageName = "cloud.fill"
        case 803, 804:
            systemImageName = "smoke.fill"
        case 300...321, 520...531:
            systemImageName = "cloud.heavyrain.fill"
        case 500...504:
            systemImageName = "cloud.rain.fill"
        case 200...232:
            systemImageName = "cloud.bolt.rain.fill"
        case 511, 600...622:
            systemImageName = "snow"
        case 701...781:
            systemImageName = "cloud.fog.fill"
        default:
            systemImageName = "sun.max.fill"
        }

        return UIImage(systemName: systemImageName)!
    }

    func getPhoto(from weatherCode: Int, completion: @escaping (UIImage) -> Void) {
        var lightOrDark: String {
            return UIScreen.main.traitCollection.userInterfaceStyle == .light ? "d" : "n"
        }

        let iconIndex: String

        switch weatherCode {
        case 800:
            iconIndex = "01"
        case 801:
            iconIndex = "02"
        case 802:
            iconIndex = "03"
        case 803, 804:
            iconIndex = "04"
        case 300...321, 520...531:
            iconIndex = "09"
        case 500...504:
            iconIndex = "10"
        case 200...232:
            iconIndex = "11"
        case 511, 600...622:
            iconIndex = "13"
        case 701...781:
            iconIndex = "50"
        default:
            iconIndex = "01"
        }

        var iconURLName: String {
            "\(iconIndex)\(lightOrDark)"
        }

        let url = URL(string: "https://openweathermap.org/img/wn/\(iconURLName)@2x.png")!
        networkService.downloadWeatherConditionImage(from: url) { data in
            completion(data)
        }

    }

}
