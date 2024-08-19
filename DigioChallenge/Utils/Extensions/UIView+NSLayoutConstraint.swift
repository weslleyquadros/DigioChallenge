//
//  UIView+NSLayoutConstraint.swift
//  DigioChallenge
//
//  Created by Weslley Tavares de Aguiar e Quadros on 18/08/24.
//

import UIKit

extension UIView {
    
    /// Adds a subview and activates constraints defined by the closure
    func addSubview(_ view: UIView, withConstraints constraints: (UIView) -> [NSLayoutConstraint]) {
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(constraints(view))
    }

    /// Adds a subview and configures its constraints to fill the superview
    func addSubviewFillingSuperview(_ view: UIView, padding: CGFloat = 0) {
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding)
        ])
    }

    /// Creates constraints to center a view within the superview
    func centerInSuperview(_ view: UIView, offsetX: CGFloat = 0, offsetY: CGFloat = 0) {
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.centerXAnchor.constraint(equalTo: centerXAnchor, constant: offsetX),
            view.centerYAnchor.constraint(equalTo: centerYAnchor, constant: offsetY)
        ])
    }

    /// Creates constraints to define a view with a specific size
    func setSize(_ view: UIView, width: CGFloat, height: CGFloat) {
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(equalToConstant: width),
            view.heightAnchor.constraint(equalToConstant: height)
        ])
    }

    /// Creates constraints to define a view with size based on proportion
    func setSizeByProportion(_ view: UIView, widthRatio: CGFloat, heightRatio: CGFloat) {
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(equalTo: widthAnchor, multiplier: widthRatio),
            view.heightAnchor.constraint(equalTo: heightAnchor, multiplier: heightRatio)
        ])
    }
    
    /// Method to define constraints using anchors
    func anchor(top: NSLayoutYAxisAnchor? = nil,
                leading: NSLayoutXAxisAnchor? = nil,
                bottom: NSLayoutYAxisAnchor? = nil,
                trailing: NSLayoutXAxisAnchor? = nil,
                paddingTop: CGFloat = 0,
                paddingLeading: CGFloat = 0,
                paddingBottom: CGFloat = 0,
                paddingTrailing: CGFloat = 0,
                width: CGFloat? = nil,
                height: CGFloat? = nil,
                centerX: NSLayoutXAxisAnchor? = nil,
                centerY: NSLayoutYAxisAnchor? = nil) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading, constant: paddingLeading).isActive = true
        }
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing, constant: -paddingTrailing).isActive = true
        }
        if let width = width {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        if let height = height {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        if let centerX = centerX {
            centerXAnchor.constraint(equalTo: centerX).isActive = true
        }
        if let centerY = centerY {
            centerYAnchor.constraint(equalTo: centerY).isActive = true
        }
    }

}
