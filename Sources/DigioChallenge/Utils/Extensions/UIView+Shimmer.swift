//
//  UIView+Shimmer.swift
//  DigioChallenge
//
//  Created by Weslley Tavares de Aguiar e Quadros on 19/08/24.
//

import UIKit

extension UIView {

    var isShimmering: Bool {
        return layer.mask != nil
    }

    /// Method to start the shimmer animation
    func startShimmering() {
        let light = UIColor.white.cgColor
        let alpha = UIColor.white.withAlphaComponent(0.7).cgColor
        let gradient = CAGradientLayer()
        gradient.colors = [alpha, light, alpha]
        gradient.frame = CGRect(x: -bounds.size.width, y: 0, width: bounds.size.width * 3, height: bounds.size.height)
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradient.locations = [0.4, 0.5, 0.6]
        gradient.name = "shimmerLayer"

        layer.mask = gradient

        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = [0.0, 0.1, 0.2]
        animation.toValue = [0.8, 0.9, 1.0]
        animation.duration = 1.5
        animation.repeatCount = .infinity
        gradient.add(animation, forKey: "shimmerAnimation")
    }

    /// Method to stop the shimmer animation
    func stopShimmering() {
        layer.mask = nil
    }

}
