//
//  StorageService.swift
//  YAWA
//
//  Created by Bassist Zero on 12/14/23.
//

import Foundation

protocol StorageServiceDelegate: AnyObject {

    func storageUpdated()

}

final class StorageService {

    weak var delegate: StorageServiceDelegate?
    static let shared = StorageService()
    private let storage = UserDefaults.standard

    private init() { }

    func saveCity(city: String?) {
        guard let city else { return }
        
        var cities = Set(loadCities())
        cities.insert(city)
        saveCities(cities: Array(cities))
        delegate?.storageUpdated()
    }

    func saveCities(cities: [String]) {
        storage.setValue(cities, forKey: Key.cities)
        delegate?.storageUpdated()
    }

    func loadCities() -> [String] {
        guard let cities = storage.array(forKey: Key.cities) as? [String] else { return [] }
        let cleanedCities = Array(Set(cities))

        return cleanedCities
    }

    func removeCity(city: String?) {
        //FIXME: - Just implement it
        guard let city else { return }

        let cities = loadCities()
        let cleanedCities = cities.filter { $0 != city }

        saveCities(cities: cleanedCities)
        delegate?.storageUpdated()
    }

    func removeCities() {
        saveCities(cities: [])
        delegate?.storageUpdated()
    }

    func isCitySaved(city: String?) -> Bool {
        guard let city else { return false }
        let cities = loadCities()
        return cities.contains(city)
    }

}

// MARK: - Keys

enum Key {

    static let cities = "cities"

}
