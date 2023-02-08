//
//  MainCoordinator.swift
//  CalculandoADistancia
//
//  Created by Marcelo Simim Santos on 2/7/23.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator {
    var navigationController: UINavigationController?

    init(navigationController: UINavigationController? = nil) {
        self.navigationController = navigationController
    }

    func eventOccurred(with type: Event) {
        switch type {
        case .savePoint:
            break
        case .restart:
            break
        }
    }

    func start() {
        if isLocationAllowed() {
            var home: UIViewController & Coordinating = HomeViewController()
            home.coordinator = self
            navigationController?.pushViewController(home, animated: true)
        } else {
            var permission: UIViewController & Coordinating = PermissionViewController()
            permission.coordinator = self
            navigationController?.pushViewController(permission, animated: true)
        }
    }

    private func isLocationAllowed() -> Bool {
        let locationDefaults = LocationDefaults()
        return locationDefaults.getLocationPermission()
    }
}
