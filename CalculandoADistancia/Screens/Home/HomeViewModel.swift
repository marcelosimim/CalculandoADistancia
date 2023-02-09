//
//  
//  HomeViewModel.swift
//  CalculandoADistancia
//
//  Created by Marcelo Simim Santos on 2/8/23.
//
//
import CoreLocation
import Foundation

protocol HomeViewModelProtocol {
    var didFinishSavingPointA: ((Coordinate) -> ()) { get set }
    var didFinishSavingPointB: ((Coordinate) -> ()) { get set }
    var didFinishCalculatingDistante: ((Double) -> ()) { get set }
    var didFinishRestarting: (() -> ()) { get set }
    var didFinishDeletingPointA: (() -> ()) { get set }

    func savePoint()
    func restart()
    func deletePointA()
}

final class HomeViewModel: NSObject, HomeViewModelProtocol {
    private let locationDefaults = LocationDefaults()
    private let locationManager = CLLocationManager()
    private var currentCoordinate: CLLocationCoordinate2D?
    private var wasPointASaved = false
    private var wasPointBSaved = false
    var didFinishSavingPointA: ((Coordinate) -> ()) = { _ in }
    var didFinishSavingPointB: ((Coordinate) -> ()) = { _ in }
    var didFinishCalculatingDistante: ((Double) -> ()) = { _ in }
    var didFinishRestarting: (() -> ()) = { }
    var didFinishDeletingPointA: (() -> ()) = { }

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.startUpdatingLocation()
    }

    func savePoint() {
        guard let currentCoordinate else { return }
        let coordinate = Coordinate(latitude: currentCoordinate.latitude, longitude: currentCoordinate.longitude)

        if !wasPointASaved {
            locationDefaults.savePoint(coordinate: coordinate, key: LocationDefaultsKey.pointA)
            wasPointASaved = true
        } else if !wasPointBSaved {
            locationDefaults.savePoint(coordinate: coordinate, key: LocationDefaultsKey.pointB)
            wasPointBSaved = true
        }

        updateView(coordinate)
    }

    func restart() {
        wasPointASaved = false
        wasPointBSaved = false
        locationDefaults.deletePoint(LocationDefaultsKey.pointA)
        locationDefaults.deletePoint(LocationDefaultsKey.pointB)
        didFinishRestarting()
        locationManager.startUpdatingLocation()
    }

    func deletePointA() {
        wasPointASaved = false
        locationDefaults.deletePoint(LocationDefaultsKey.pointA)
        didFinishDeletingPointA()
    }

    private func updateView(_ coordinate: Coordinate) {
        if !wasPointBSaved {
            didFinishSavingPointA(coordinate)
        } else {
            didFinishSavingPointB(coordinate)
            calculateDistance()
        }
    }

    private func calculateDistance() {
        guard let pointA = locationDefaults.getPoint(LocationDefaultsKey.pointA), let pointB = locationDefaults.getPoint(LocationDefaultsKey.pointB) else { return }

        let pointALocation = CLLocation(latitude: pointA.latitude, longitude: pointA.longitude)
        let pointBLocation = CLLocation(latitude: pointB.latitude, longitude: pointB.longitude)
        let distance = pointALocation.distance(from: pointBLocation)

        didFinishCalculatingDistante(distance/1000)
        locationManager.stopUpdatingLocation()
    }
}

extension HomeViewModel: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let coordinate: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        currentCoordinate = coordinate
        print(locations)
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
