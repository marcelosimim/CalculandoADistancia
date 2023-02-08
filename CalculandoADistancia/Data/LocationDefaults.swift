//
//  LocationDefaults.swift
//  CalculandoADistancia
//
//  Created by Marcelo Simim Santos on 2/7/23.
//

import Foundation

class LocationDefaults {
    private let defaults = UserDefaults.standard

    func updateLocationPermission(_ allowed: Bool) {
        defaults.setValue(allowed, forKey: LocationDefaultsKey.locationPermission.rawValue)
    }

    func getLocationPermission() -> Bool {
        defaults.bool(forKey: LocationDefaultsKey.locationPermission.rawValue)
    }
}

enum LocationDefaultsKey: String {
    case locationPermission = "locationPermission"
    case pointA = "pointA"
    case pointB = "pointB"
}

