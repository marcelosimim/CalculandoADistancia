//
//  LocationDefaults.swift
//  CalculandoADistancia
//
//  Created by Marcelo Simim Santos on 2/7/23.
//

import Foundation

class LocationDefaults {
    private let defaults = UserDefaults.standard

    func savePoint(coordinate: Coordinate, key: LocationDefaultsKey) {
        if let encoded = try? JSONEncoder().encode(coordinate) {
            defaults.set(encoded, forKey: key.rawValue)
        }
    }

    func getPoint(_ key: LocationDefaultsKey) -> Coordinate? {
        if let data = defaults.object(forKey: key.rawValue) as? Data, let coordinate = try? JSONDecoder().decode(Coordinate.self, from: data) {
            return coordinate
        }
        return nil
    }

    func deletePoint(_ key: LocationDefaultsKey) {
        defaults.removeObject(forKey: key.rawValue)
    }
}

enum LocationDefaultsKey: String {
    case locationPermission = "locationPermission"
    case pointA = "pointA"
    case pointB = "pointB"
}

