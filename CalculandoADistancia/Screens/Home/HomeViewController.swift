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
        pointASaved.delegate = self
        pointBSaved.pointLabel.text = "Ponto B"
        pointBSaved.deleteButton.isHidden = true

        distanceView.titleLabel.text = "Distância"
    }

    private func viewModelBinds() {
        viewModel.didFinishSavingPointA = { [weak self] coordinate in
            self?.pointASaved.latValue.text = "\(coordinate.latitude)"
            self?.pointASaved.lonValue.text = "\(coordinate.latitude)"
            self?.pointAWaiting.isHidden = true
            self?.pointASaved.isHidden = false
            self?.pointBWaiting.isHidden = false
        }

        viewModel.didFinishSavingPointB = { [weak self] coordinate in
            self?.pointBSaved.latValue.text = "\(coordinate.latitude)"
            self?.pointBSaved.lonValue.text = "\(coordinate.latitude)"
            self?.pointBWaiting.isHidden = true
            self?.pointBSaved.isHidden = false
            self?.pointASaved.deleteButton.isHidden = true
        }

        viewModel.didFinishCalculatingDistante = { [weak self] distance in
            self?.saveButton.isHidden = true
            self?.restartButton.isHidden = false
            self?.distanceView.isHidden = false
            self?.distanceView.subtitleLabel.text = "\(distance) km"
        }

        viewModel.didFinishRestarting = { [weak self] in
            self?.pointASaved.isHidden = true
            self?.pointASaved.deleteButton.isHidden = false
            self?.pointBSaved.isHidden = true
            self?.distanceView.isHidden = true
            self?.restartButton.isHidden = true

            self?.pointAWaiting.isHidden = false
            self?.pointBWaiting.isHidden = false
            self?.saveButton.isHidden = false
        }

        viewModel.didFinishDeletingPointA = { [weak self] in
            self?.pointAWaiting.isHidden = false
            self?.pointASaved.isHidden = true
        }
    }
}

extension HomeViewController: MainButtonDelegate, SecondButtonDelegate, GreenCardViewDelegate {
    func didTapMainButton() {
        viewModel.getCoordinates()
    }

    func didTapSecondButton() {
        viewModel.restart()
    }

    func didTapGreenCardDeleteButton() {
        let alertController = UIAlertController(title: "Deletar ponto", message: "Tem certeza que deseja deletar o Ponto A?", preferredStyle: .alert)
        let actionCancel = UIAlertAction(title: "Não", style: .cancel)
        let actionConfirm = UIAlertAction(title: "Sim", style: .default) { [weak self] _ in
            self?.viewModel.deletePointA()
        }

        alertController.addAction(actionCancel)
        alertController.addAction(actionConfirm)

        present(alertController, animated: true)
    }
}
