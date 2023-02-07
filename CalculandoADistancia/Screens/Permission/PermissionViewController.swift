//
//  PermissionViewController.swift
//  CalculandoADistancia
//
//  Created by Marcelo Simim Santos on 2/7/23.
//

import UIKit

class PermissionViewController: UIViewController {
    private lazy var viewModel: PermissionViewModelProtocol = PermissionViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
}
