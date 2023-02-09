//
//  
//  NoPermissionView.swift
//  CalculandoADistancia
//
//  Created by Marcelo Simim Santos on 2/9/23.
//
//

import Foundation
import UIKit

protocol NoPermissionViewProtocol {
    func setupDelegate(_ controller: UIViewController)
}

final class NoPermissionView: UIView, NoPermissionViewProtocol {
    static let identifier = "NoPermissionView"
    @IBOutlet weak var mainButton: MainButton!

    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
       initSubviews()
    }

    override init(frame: CGRect) {
       super.init(frame: frame)
       initSubviews()
    }

    func setupDelegate(_ controller: UIViewController) {
        mainButton.delegate = controller as? MainButtonDelegate
    }

    private func initSubviews() {
        let nib = UINib(nibName: NoPermissionView.identifier, bundle: nil)
        guard let view = nib.instantiate(withOwner: self, options: nil).first as?
                           UIView else {fatalError("Unable to convert nib")}
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)

        setupMainButton()
    }

    private func setupMainButton() {
        mainButton.titleLabel.text = "ATIVAR LOCALIZAÇÃO"
    }
}
