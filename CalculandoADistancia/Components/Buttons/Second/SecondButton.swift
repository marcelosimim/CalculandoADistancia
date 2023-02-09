//
//  SecondButton.swift
//  CalculandoADistancia
//
//  Created by Marcelo Simim Santos on 2/8/23.
//

import UIKit

protocol SecondButtonDelegate: AnyObject {
    func didTapSecondButton()
}

class SecondButton: UIView {
    static let identifier = "SecondButton"
    weak var delegate: SecondButtonDelegate? 
    @IBOutlet weak var titleLabel: UILabel!

    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
       initSubviews()
    }

    override init(frame: CGRect) {
       super.init(frame: frame)
       initSubviews()
    }

    private func initSubviews() {
        let nib = UINib(nibName: SecondButton.identifier, bundle: nil)
        guard let view = nib.instantiate(withOwner: self, options: nil).first as?
                           UIView else {fatalError("Unable to convert nib")}
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
        setupLayer()
        addGesture()
    }

    private func setupLayer() {
        layer.borderWidth = 1
        layer.cornerRadius = 12
        layer.borderColor = UIColor(red: 215/255, green: 245/255, blue: 193/255, alpha: 1).cgColor
    }

    private func addGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapSecondButton))
        addGestureRecognizer(tap)
    }

    @objc private func didTapSecondButton() {
        delegate?.didTapSecondButton()
    }
}
