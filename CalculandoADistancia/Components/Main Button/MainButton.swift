//
//  MainButton.swift
//  CalculandoADistancia
//
//  Created by Marcelo Simim Santos on 2/7/23.
//

import UIKit

class MainButton: UIView {
    @IBOutlet weak var titleLabel: UILabel!
    static let identifier = "MainButton"

    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
       initSubviews()
    }

   override init(frame: CGRect) {
       super.init(frame: frame)
       initSubviews()
   }

   private func initSubviews() {
       let nib = UINib(nibName: MainButton.identifier, bundle: nil)
       guard let view = nib.instantiate(withOwner: self, options: nil).first as?
                           UIView else {fatalError("Unable to convert nib")}
       view.frame = bounds
       view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
       addSubview(view)
   }

    func setupTitle(_ text: String) {
        titleLabel.text = text
    }
}
