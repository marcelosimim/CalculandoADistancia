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
    var openSettings: (() -> ()) { get set }
    func requestLocation()
    func deinitDelegate()
}

final class NoPermissionViewModel: NSObject, NoPermissionViewModelProtocol {
    private let locationManager = CLLocationManager()
    var hasUserPermission: (() -> ()) = { }
    var openSettings: (() -> ()) = { }

    override init() {
        super.init()
        locationManager.delegate = self
    }
    
    func deinitDelegate() {
        locationManager.delegate = nil
    }

    func requestLocation() {
        if locationManager.authorizationStatus == .denied {
            openSettings()
        } else if locationManager.authorizationStatus == .notDetermined {
            locationManager.requestAlwaysAuthorization()
        }
    }
}

extension NoPermissionViewModel: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch locationManager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            hasUserPermission()
        case .denied, .notDetermined, .restricted:
            break
        @unknown default:
            fatalError()
        }
    }
}
