//
//  HourlyForecastModel.swift
//  YAWA
//
//  Created by Bassist Zero on 12/14/23.
//

import Foundation

// MARK: - HourlyForecast
struct HourlyForecastModel: Decodable {
    let list: [List]
    let city: City

    // MARK: - City
    struct City: Decodable {
        let id: Int
        let name: String
        let coord: Coord
        let country: String
        let population, timezone, sunrise, sunset: Int
    }

    // MARK: - Coord
    struct Coord: Decodable {
        let lat, lon: Double
    }

    // MARK: - List
    struct List: Decodable {
        let dt: Int
        let main: Main
        let weather: [Weather]
        let clouds: Clouds
        let wind: Wind
        let visibility: Int
        let pop: Double
        let sys: Sys
        let dtTxt: String

    }

    // MARK: - Clouds
    struct Clouds: Decodable {
        let all: Int
    }

    // MARK: - Main
    struct Main: Decodable {
        let temp, feelsLike, tempMin, tempMax: Double
        let pressure, seaLevel, grndLevel, humidity: Int
        let tempKf: Double

    }

    // MARK: - Rain
    struct Rain: Decodable {
        let the3H: Double
    }

    // MARK: - Sys
    struct Sys: Decodable {
        let pod: String
    }

    // MARK: - Weather
    struct Weather: Decodable {
        let id: Int
        let main, description, icon: String
    }

    // MARK: - Wind
    struct Wind: Decodable {
        let speed: Double
        let deg: Int
        let gust: Double
    }

}
