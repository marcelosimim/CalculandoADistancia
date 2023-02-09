//
//  PermissionViewController.swift
//  CalculandoADistancia
//
//  Created by Marcelo Simim Santos on 2/7/23.
//

import UIKit

class PermissionViewController: UIViewController, Coordinating {
    private lazy var viewModel: PermissionViewModelProtocol = PermissionViewModel()
    @IBOutlet weak var mainButton: MainButton!
    var coordinator: Coordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupMainButton()
        viewModelBinds()
    }

    private func setupMainButton() {
        mainButton.titleLabel.text = "ATIVAR LOCALIZAÇÃO"
        mainButton.delegate = self
    }

    private func viewModelBinds() {
        viewModel.hasUserPermission = { [weak self] in
            self?.coordinator?.eventOccurred(with: .home)
        }
    }
}

extension PermissionViewController: MainButtonDelegate {
    func didTapMainButton() {
        viewModel.requestLocation()
    }
}
