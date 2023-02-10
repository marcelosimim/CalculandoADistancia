//
//  HomeView.swift
//  CalculandoADistancia
//
//  Created by Marcelo Simim Santos on 2/9/23.
//

import UIKit

protocol HomeViewProtocol {
    func didFinishSavingPointA(coordinate: Coordinate)
    func didFinishSavingPointB(coordinate: Coordinate)
    func didFinishCalculatingDistante(distance: Double)
    func didFinishRestarting()
    func didFinishDeletingPointA()
    func setupDelegate(_ controller: UIViewController)
}

class HomeView: UIView, HomeViewProtocol {
    static let identifier = "HomeView"

    @IBOutlet weak var pointAWaiting: GrayCardView!
    @IBOutlet weak var pointBWaiting: GrayCardView!
    @IBOutlet weak var pointASaved: GreenCardView!
    @IBOutlet weak var pointBSaved: GreenCardView!
    @IBOutlet weak var saveButton: MainButton!
    @IBOutlet weak var distanceView: GrayCardView!
    @IBOutlet weak var restartButton: SecondButton!

    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
       initSubviews()
    }

    override init(frame: CGRect) {
       super.init(frame: frame)
       initSubviews()
    }

    private func initSubviews() {
        let nib = UINib(nibName: HomeView.identifier, bundle: nil)
        guard let view = nib.instantiate(withOwner: self, options: nil).first as?
                           UIView else {fatalError("Unable to convert nib")}
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
        setupView()
    }

    private func setupView() {
        saveButton.titleLabel.text = "SALVAR PONTO"
        restartButton.titleLabel.text = "REINICIAR"

        pointAWaiting.titleLabel.text = "Ponto A"
        pointAWaiting.subtitleLabel.text = "aguardando posição"
        pointBWaiting.titleLabel.text = "Ponto B"
        pointBWaiting.subtitleLabel.text = "aguardando posição"

        pointASaved.pointLabel.text = "Ponto A"

        pointBSaved.pointLabel.text = "Ponto B"
        pointBSaved.deleteButton.isHidden = true

        distanceView.titleLabel.text = "Distância"
    }

    func didFinishSavingPointA(coordinate: Coordinate) {
        pointASaved.latValue.text = "\(coordinate.latitude)"
        pointASaved.lonValue.text = "\(coordinate.latitude)"
        pointAWaiting.isHidden = true
        pointASaved.isHidden = false
        pointBWaiting.isHidden = false
    }

    func didFinishSavingPointB(coordinate: Coordinate) {
        pointBSaved.latValue.text = "\(coordinate.latitude)"
        pointBSaved.lonValue.text = "\(coordinate.latitude)"
        pointBWaiting.isHidden = true
        pointBSaved.isHidden = false
        pointASaved.deleteButton.isHidden = true
    }

    func didFinishCalculatingDistante(distance: Double) {
        saveButton.isHidden = true
        restartButton.isHidden = false
        distanceView.isHidden = false
        distanceView.subtitleLabel.text = String(format: "%.2f km", distance)
    }

    func didFinishRestarting() {
        pointASaved.isHidden = true
        pointASaved.deleteButton.isHidden = false
        pointBSaved.isHidden = true
        distanceView.isHidden = true
        restartButton.isHidden = true

        pointAWaiting.isHidden = false
        pointBWaiting.isHidden = false
        saveButton.isHidden = false
    }

    func didFinishDeletingPointA() {
        pointAWaiting.isHidden = false
        pointASaved.isHidden = true
        pointBWaiting.isHidden = true
    }

    func setupDelegate(_ controller: UIViewController) {
        saveButton.delegate = controller as? MainButtonDelegate
        restartButton.delegate = controller as? SecondButtonDelegate
        pointASaved.delegate = controller as? GreenCardViewDelegate
    }
}
