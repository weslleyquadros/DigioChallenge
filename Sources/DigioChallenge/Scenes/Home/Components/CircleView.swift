//
//  CircleView.swift
//  DigioChallenge
//
//  Created by Weslley Tavares de Aguiar e Quadros on 19/08/24.
//

import UIKit

final class CircleView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    private func setupView() {
        let outerCircleDiameter: CGFloat = 40
        let innerCircleDiameter: CGFloat = 19

        let outerCircle = UIView()
        outerCircle.backgroundColor = .clear
        outerCircle.layer.borderColor = AppStyle.Colors.primary.cgColor
        outerCircle.layer.borderWidth = 6
        outerCircle.layer.cornerRadius = outerCircleDiameter / 2
        addSubview(outerCircle)

        outerCircle.anchor(width: outerCircleDiameter,
                           height: outerCircleDiameter,
                           centerX: centerXAnchor,
                           centerY: centerYAnchor)

        let innerCircle = UIView()
        innerCircle.backgroundColor = AppStyle.Colors.tealColor
        innerCircle.layer.cornerRadius = innerCircleDiameter / 2
        addSubview(innerCircle)

        innerCircle.anchor(width: innerCircleDiameter,
                           height: innerCircleDiameter,
                           centerX: centerXAnchor,
                           centerY: centerYAnchor)
    }

}
