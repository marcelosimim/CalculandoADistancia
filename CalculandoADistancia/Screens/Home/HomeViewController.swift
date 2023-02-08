//
//  HomeViewController.swift
//  CalculandoADistancia
//
//  Created by Marcelo Simim Santos on 2/8/23.
//

import UIKit

class HomeViewController: UIViewController, Coordinating {
    private lazy var viewModel: HomeViewModelProtocol = HomeViewModel()
    var coordinator: Coordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
