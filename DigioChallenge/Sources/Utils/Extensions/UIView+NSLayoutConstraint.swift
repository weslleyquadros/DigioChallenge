//
//  UIView+NSLayoutConstraint.swift
//  DigioChallenge
//
//  Created by Weslley Tavares de Aguiar e Quadros on 18/08/24.
//

import UIKit

extension UIView {

    enum ConstraintRelation {
        case equal
        case greaterThanOrEqual
        case lessThanOrEqual
    }

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

    func anchor(
        top: NSLayoutYAxisAnchor? = nil,
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
        centerY: NSLayoutYAxisAnchor? = nil,
        topRelation: ConstraintRelation = .equal,
        leadingRelation: ConstraintRelation = .equal,
        bottomRelation: ConstraintRelation = .equal,
        trailingRelation: ConstraintRelation = .equal,
        widthRelation: ConstraintRelation = .equal,
        heightRelation: ConstraintRelation = .equal
    ) {
        translatesAutoresizingMaskIntoConstraints = false

        setupTopConstraint(top: top, relation: topRelation, constant: paddingTop)
        setupLeadingConstraint(leading: leading, relation: leadingRelation, constant: paddingLeading)
        setupBottomConstraint(bottom: bottom, relation: bottomRelation, constant: -paddingBottom)
        setupTrailingConstraint(trailing: trailing, relation: trailingRelation, constant: -paddingTrailing)
        setupWidthConstraint(width: width, relation: widthRelation)
        setupHeightConstraint(height: height, relation: heightRelation)
        setupCenterConstraints(centerX: centerX, centerY: centerY)
    }

    private func setupTopConstraint(top: NSLayoutYAxisAnchor?, relation: ConstraintRelation, constant: CGFloat) {
        guard let top = top else { return }
        let constraint: NSLayoutConstraint
        switch relation {
        case .equal:
            constraint = topAnchor.constraint(equalTo: top, constant: constant)
        case .greaterThanOrEqual:
            constraint = topAnchor.constraint(greaterThanOrEqualTo: top, constant: constant)
        case .lessThanOrEqual:
            constraint = topAnchor.constraint(lessThanOrEqualTo: top, constant: constant)
        }
        constraint.isActive = true
    }

    private func setupLeadingConstraint(leading: NSLayoutXAxisAnchor?, relation: ConstraintRelation, constant: CGFloat) {
        guard let leading = leading else { return }
        let constraint: NSLayoutConstraint
        switch relation {
        case .equal:
            constraint = leadingAnchor.constraint(equalTo: leading, constant: constant)
        case .greaterThanOrEqual:
            constraint = leadingAnchor.constraint(greaterThanOrEqualTo: leading, constant: constant)
        case .lessThanOrEqual:
            constraint = leadingAnchor.constraint(lessThanOrEqualTo: leading, constant: constant)
        }
        constraint.isActive = true
    }

    private func setupBottomConstraint(bottom: NSLayoutYAxisAnchor?, relation: ConstraintRelation, constant: CGFloat) {
        guard let bottom = bottom else { return }
        let constraint: NSLayoutConstraint
        switch relation {
        case .equal:
            constraint = bottomAnchor.constraint(equalTo: bottom, constant: constant)
        case .greaterThanOrEqual:
            constraint = bottomAnchor.constraint(greaterThanOrEqualTo: bottom, constant: constant)
        case .lessThanOrEqual:
            constraint = bottomAnchor.constraint(lessThanOrEqualTo: bottom, constant: constant)
        }
        constraint.isActive = true
    }

    private func setupTrailingConstraint(trailing: NSLayoutXAxisAnchor?, relation: ConstraintRelation, constant: CGFloat) {
        guard let trailing = trailing else { return }
        let constraint: NSLayoutConstraint
        switch relation {
        case .equal:
            constraint = trailingAnchor.constraint(equalTo: trailing, constant: constant)
        case .greaterThanOrEqual:
            constraint = trailingAnchor.constraint(greaterThanOrEqualTo: trailing, constant: constant)
        case .lessThanOrEqual:
            constraint = trailingAnchor.constraint(lessThanOrEqualTo: trailing, constant: constant)
        }
        constraint.isActive = true
    }

    private func setupWidthConstraint(width: CGFloat?, relation: ConstraintRelation) {
        guard let width = width else { return }
        let constraint: NSLayoutConstraint
        switch relation {
        case .equal:
            constraint = widthAnchor.constraint(equalToConstant: width)
        case .greaterThanOrEqual:
            constraint = widthAnchor.constraint(greaterThanOrEqualToConstant: width)
        case .lessThanOrEqual:
            constraint = widthAnchor.constraint(lessThanOrEqualToConstant: width)
        }
        constraint.isActive = true
    }

    private func setupHeightConstraint(height: CGFloat?, relation: ConstraintRelation) {
        guard let height = height else { return }
        let constraint: NSLayoutConstraint
        switch relation {
        case .equal:
            constraint = heightAnchor.constraint(equalToConstant: height)
        case .greaterThanOrEqual:
            constraint = heightAnchor.constraint(greaterThanOrEqualToConstant: height)
        case .lessThanOrEqual:
            constraint = heightAnchor.constraint(lessThanOrEqualToConstant: height)
        }
        constraint.isActive = true
    }

    private func setupCenterConstraints(centerX: NSLayoutXAxisAnchor?, centerY: NSLayoutYAxisAnchor?) {
        if let centerX = centerX {
            let constraint = centerXAnchor.constraint(equalTo: centerX)
            constraint.isActive = true
        }
        if let centerY = centerY {
            let constraint = centerYAnchor.constraint(equalTo: centerY)
            constraint.isActive = true
        }
    }
}
