//
//  
//  NoPermissionViewModel.swift
//  CalculandoADistancia
//
//  Created by Marcelo Simim Santos on 2/9/23.
//
//
import CoreLocation
import Foundation
import UIKit

protocol NoPermissionViewModelProtocol {
    var hasUserPermission: (() -> ()) { get set }
    func requestLocation()
}

final class NoPermissionViewModel: NSObject, NoPermissionViewModelProtocol {
    private let locationManager = CLLocationManager()
    private let locationDefaults = LocationDefaults()
    var hasUserPermission: (() -> ()) = { }

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

extension NoPermissionViewModel: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch locationManager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            locationDefaults.updateLocationPermission(true)
            hasUserPermission()
        case .denied, .notDetermined, .restricted:
            locationDefaults.updateLocationPermission(false)
        @unknown default:
            fatalError()
        }
    }
}
