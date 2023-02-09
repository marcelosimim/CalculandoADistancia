//
//  
//  NoPermissionViewController.swift
//  CalculandoADistancia
//
//  Created by Marcelo Simim Santos on 2/9/23.
//
//
import UIKit

class NoPermissionViewController: UIViewController, Coordinating {
    private lazy var customView: NoPermissionViewProtocol = NoPermissionView()
    private lazy var viewModel: NoPermissionViewModelProtocol = NoPermissionViewModel()
    var coordinator: Coordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModelBinds()
    }

    override func loadView() {
        super.loadView()
        view = customView as? UIView
        customView.setupDelegate(self)
    }

    private func viewModelBinds() {
        viewModel.hasUserPermission = { [weak self] in
            self?.coordinator?.eventOccurred(with: .home)
        }
    }
}

extension NoPermissionViewController: MainButtonDelegate {
    func didTapMainButton() {
        viewModel.requestLocation()
    }
}
