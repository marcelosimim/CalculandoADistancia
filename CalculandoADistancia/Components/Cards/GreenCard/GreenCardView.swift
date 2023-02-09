//
//  GreenCardView.swift
//  CalculandoADistancia
//
//  Created by Marcelo Simim Santos on 2/8/23.
//

import UIKit

class GreenCardView: UIView {
    static let identifier = "GreenCardView"

    @IBOutlet weak var pointLabel: UILabel!
    @IBOutlet weak var latValue: UILabel!
    @IBOutlet weak var lonValue: UILabel!

    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
       initSubviews()
    }

    override init(frame: CGRect) {
       super.init(frame: frame)
       initSubviews()
    }

    private func initSubviews() {
        let nib = UINib(nibName: GreenCardView.identifier, bundle: nil)
        guard let view = nib.instantiate(withOwner: self, options: nil).first as?
                           UIView else {fatalError("Unable to convert nib")}
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
    }
}
