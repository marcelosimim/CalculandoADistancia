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
        customView.mainButtonDelegate = self
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel.deinitDelegate()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }

    private func viewModelBinds() {
        viewModel.hasUserPermission = { [weak self] in
            self?.coordinator?.eventOccurred(with: .home)
        }
        
        viewModel.openSettings = { [weak self] in
            self?.coordinator?.eventOccurred(with: .settings)
        }
    }
}

extension NoPermissionViewController: MainButtonDelegate {
    func didTapMainButton() {
        viewModel.requestLocation()
    }
}
