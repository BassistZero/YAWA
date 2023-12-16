//
//  WeatherModel.swift
//  YAWA
//
//  Created by Bassist Zero on 12/14/23.
//

struct WeatherModel: Decodable {
    let coord: Coord
    let weather: [Weather]
    let base: String
    let main: Main
    let visibility: Int
    let wind: Wind
    let clouds: Clouds
    let dt: Int
    let sys: Sys
    let timezone, id: Int
    let name: String
    let cod: Int

    // MARK: - Clouds
    struct Clouds: Decodable {
        let all: Int
    }

    // MARK: - Coord
    struct Coord: Decodable {
        let lon, lat: Double
    }

    // MARK: - Main
    struct Main: Decodable {
        let temp, feelsLike, tempMin, tempMax: Double
        let pressure, humidity: Int

    }

    // MARK: - Sys
    struct Sys: Decodable {
        let type, id: Int
        let country: String
        let sunrise, sunset: Int
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
    }

}
