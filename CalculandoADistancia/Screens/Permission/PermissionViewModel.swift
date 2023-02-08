//
//  
//  PermissionViewModel.swift
//  CalculandoADistancia
//
//  Created by Marcelo Simim Santos on 2/7/23.
//
//
import CoreLocation
import Foundation
import UIKit

protocol PermissionViewModelProtocol {
    func requestLocation()
}

final class PermissionViewModel: NSObject, PermissionViewModelProtocol {
    private let locationManager = CLLocationManager()
    private let locationDefaults = LocationDefaults()

    override init() {
        super.init()
        locationManager.delegate = self
    }

    func requestLocation() {
        if locationManager.authorizationStatus == .denied {
            openSettings()
        } else if locationManager.authorizationStatus == .notDetermined {
            locationManager.requestAlwaysAuthorization()
        }
    }

    private func openSettings() {
        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else { return }
        if UIApplication.shared.canOpenURL(settingsUrl) {
            UIApplication.shared.open(settingsUrl) { _ in }
        }
    }
}

extension PermissionViewModel: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch locationManager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            locationDefaults.updateLocationPermission(true)
        case .denied, .notDetermined, .restricted:
            locationDefaults.updateLocationPermission(false)
        @unknown default:
            fatalError()
        }
    }
}
