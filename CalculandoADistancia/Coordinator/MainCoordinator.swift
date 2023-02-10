//
//  MainCoordinator.swift
//  CalculandoADistancia
//
//  Created by Marcelo Simim Santos on 2/7/23.
//

import CoreLocation
import Foundation
import UIKit

class MainCoordinator: Coordinator {
    private let locationManager = CLLocationManager()
    var navigationController: UINavigationController?

    init(navigationController: UINavigationController? = nil) {
        self.navigationController = navigationController
    }

    func eventOccurred(with type: Event) {
        switch type {
        case .home:
            var homeVC: UIViewController & Coordinating = HomeViewController()
            homeVC.coordinator = self
            homeVC.navigationItem.hidesBackButton = true
            self.navigationController?.pushViewController(homeVC, animated: true)
        case .settings:
            openSettings()
        }
    }

    func start() {
        if isLocationAllowed() {
            var home: UIViewController & Coordinating = HomeViewController()
            home.coordinator = self
            navigationController?.pushViewController(home, animated: true)
        } else {
            var permission: UIViewController & Coordinating = NoPermissionViewController()
            permission.coordinator = self
            navigationController?.pushViewController(permission, animated: true)
        }
    }

    private func isLocationAllowed() -> Bool {
        return locationManager.authorizationStatus.rawValue == 3
    }

    private func openSettings() {
        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else { return }
        if UIApplication.shared.canOpenURL(settingsUrl) {
            UIApplication.shared.open(settingsUrl) { _ in }
        }
    }
}
