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
    
    @IBOutlet weak var pointAWaiting: GrayCardView!
    @IBOutlet weak var pointBWaiting: GrayCardView!
    @IBOutlet weak var pointASaved: GreenCardView!
    @IBOutlet weak var pointBSaved: GreenCardView!
    @IBOutlet weak var saveButton: MainButton!
    @IBOutlet weak var distanceView: GrayCardView!
    @IBOutlet weak var restartButton: SecondButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Calcule a distância"
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupView()
        viewModelBinds()
    }

    private func setupView() {
        saveButton.titleLabel.text = "SALVAR PONTO"
        saveButton.delegate = self

        restartButton.titleLabel.text = "REINICIAR"
        restartButton.delegate = self
        
        pointAWaiting.titleLabel.text = "Ponto A"
        pointAWaiting.subtitleLabel.text = "aguardando posição"
        pointBWaiting.titleLabel.text = "Ponto B"
        pointBWaiting.subtitleLabel.text = "aguardando posição"

        pointASaved.pointLabel.text = "Ponto A"
        pointBSaved.pointLabel.text = "Ponto B"

        distanceView.titleLabel.text = "Distância"
    }

    private func viewModelBinds() {
        viewModel.didFinishSavingPointA = { [weak self] in
            self?.pointAWaiting.isHidden = true
            self?.pointASaved.isHidden = false
            self?.pointBWaiting.isHidden = false
        }

        viewModel.didFinishSavingPointB = { [weak self] in
            self?.pointBWaiting.isHidden = true
            self?.pointBSaved.isHidden = false
            self?.saveButton.isHidden = true
            self?.distanceView.isHidden = false
            self?.restartButton.isHidden = false
        }
    }
}

extension HomeViewController: MainButtonDelegate, SecondButtonDelegate {
    func didTapMainButton() {
        viewModel.savePoint()
    }

    func didTapSecondButton() {
        print("reiniciar")
    }
}
