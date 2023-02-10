//
//  Home2ViewController.swift
//  CalculandoADistancia
//
//  Created by Marcelo Simim Santos on 2/9/23.
//

import UIKit

class HomeViewController: UIViewController, Coordinating {
    private lazy var customView: HomeViewProtocol = HomeView()
    private lazy var viewModel: HomeViewModelProtocol = HomeViewModel()
    var coordinator: Coordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModelBinds()
    }

    override func loadView() {
        super.loadView()
        view = customView as? UIView
        title = "Calcule a distância"
        customView.setupDelegate(self)
    }

    private func viewModelBinds() {
       viewModel.didFinishSavingPointA = { [weak self] coordinate in
           self?.customView.didFinishSavingPointA(coordinate: coordinate)
       }

       viewModel.didFinishSavingPointB = { [weak self] coordinate in
           self?.customView.didFinishSavingPointB(coordinate: coordinate)
       }

       viewModel.didFinishCalculatingDistante = { [weak self] distance in
           self?.customView.didFinishCalculatingDistante(distance: distance)
       }

       viewModel.didFinishRestarting = { [weak self] in
           self?.customView.didFinishRestarting()
       }

       viewModel.didFinishDeletingPointA = { [weak self] in
           self?.customView.didFinishDeletingPointA()
       }

        viewModel.hasNoLocationPermission = { [weak self] in
            let alert = UIAlertController(title: "Sem permissão", message:  "Você removeu as permissões de localização. Por favor, conceda novamente nos ajustes.", preferredStyle: .alert)
            let actionConfig = UIAlertAction(title: "Configurações", style: .default) { [weak self] _ in 
                self?.coordinator?.eventOccurred(with: .settings)
            }
            let cancel = UIAlertAction(title: "Cancelar", style: .cancel)
            alert.addAction(actionConfig)
            alert.addAction(cancel)

            self?.present(alert, animated: true)
        }
   }
}

extension HomeViewController: MainButtonDelegate, SecondButtonDelegate, GreenCardViewDelegate {
    func didTapMainButton() {
        viewModel.savePoint()
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
