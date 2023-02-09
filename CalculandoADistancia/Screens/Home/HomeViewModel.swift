//
//  
//  HomeViewModel.swift
//  CalculandoADistancia
//
//  Created by Marcelo Simim Santos on 2/8/23.
//
//
import Foundation

protocol HomeViewModelProtocol {
    var didFinishSavingPointA: (() -> ()) { get set }
    var didFinishSavingPointB: (() -> ()) { get set }

    func savePoint()
}

final class HomeViewModel: HomeViewModelProtocol {
    private var wasPointASaved = false
    private var wasPointBSaved = false
    var didFinishSavingPointA: (() -> ()) = { }
    var didFinishSavingPointB: (() -> ()) = { }

    func savePoint() {
        if !wasPointASaved {
            print("salvando ponto A...")
            wasPointASaved = true
            didFinishSavingPointA()
        } else if !wasPointBSaved {
            print("salvando ponto B...")
            wasPointBSaved = true
            didFinishSavingPointB()
        }
    }
}
