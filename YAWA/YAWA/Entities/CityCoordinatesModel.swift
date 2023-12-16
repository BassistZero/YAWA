//
//  CityCoordinatesModel.swift
//  YAWA
//
//  Created by Bassist Zero on 12/15/23.
//

struct CityCoordinatesModelElement: Decodable {
    let lat, lon: Double
}

typealias CityCoordinatesModel = [CityCoordinatesModelElement]
