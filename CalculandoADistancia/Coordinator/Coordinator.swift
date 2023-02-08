//
//  Coordinator.swift
//  CalculandoADistancia
//
//  Created by Marcelo Simim Santos on 2/7/23.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController? { get set }

    func eventOccurred(with type: Event)
    func start()
}

protocol Coordinating {
    var coordinator: Coordinator? { get set }
}
