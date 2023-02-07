//
//  PermissionViewController.swift
//  CalculandoADistancia
//
//  Created by Marcelo Simim Santos on 2/7/23.
//

import UIKit

class PermissionViewController: UIViewController {
    private lazy var viewModel: PermissionViewModelProtocol = PermissionViewModel()

    @IBOutlet weak var mainButton: MainButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        //view.backgroundColor = .white
        setupMainButton()
    }

    private func setupMainButton() {
        mainButton.setupTitle("ATIVAR LOCALIZAÇÃO")
    }
}
