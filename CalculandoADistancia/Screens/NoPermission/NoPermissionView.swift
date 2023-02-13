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
    var mainButtonDelegate: MainButtonDelegate? { get set }

}

final class NoPermissionView: UIView, NoPermissionViewProtocol {
    static let identifier = "NoPermissionView"
    @IBOutlet weak var mainButton: MainButton!
    weak var mainButtonDelegate: MainButtonDelegate? {
        willSet {
            mainButton.delegate = newValue
        }
    }

    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
       initSubviews()
    }

    override init(frame: CGRect) {
       super.init(frame: frame)
       initSubviews()
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
