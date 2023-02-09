//
//  GrayCardView.swift
//  CalculandoADistancia
//
//  Created by Marcelo Simim Santos on 2/8/23.
//

import UIKit

class GrayCardView: UIView {
    static let identifier = "GrayCardView"
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
       initSubviews()
    }

    override init(frame: CGRect) {
       super.init(frame: frame)
       initSubviews()
    }

    private func initSubviews() {
        let nib = UINib(nibName: GrayCardView.identifier, bundle: nil)
        guard let view = nib.instantiate(withOwner: self, options: nil).first as?
                           UIView else {fatalError("Unable to convert nib")}
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
    }
}
