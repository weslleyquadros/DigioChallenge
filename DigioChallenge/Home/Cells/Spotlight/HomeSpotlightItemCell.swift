//
//  HomeSpotlightItemCell.swift
//  DigioChallenge
//
//  Created by Weslley Tavares de Aguiar e Quadros on 18/08/24.
//

import UIKit

final class HomeSpotlightItemCell: UICollectionViewCell, CodeView {

    static let reuseIdentifier = "HomeCardItemCell"
    
    private let imageView = UIImageView()
    private let cardView = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with spotlight: Spotlight) {
        imageView.loadImage(from: spotlight.bannerURL)
    }
}

//MARK: - CodeView

extension HomeSpotlightItemCell {

    func buildViewHierarchy() {
        contentView.addSubview(cardView)
        cardView.addSubviewFillingSuperview(imageView)
    }
    
    func setupConstraints() {
        cardView.anchor(leading: contentView.leadingAnchor,
                        trailing: contentView.trailingAnchor,
                        height: 160)
        cardView.centerInSuperview(imageView)
    }
    
    func setupAdditionalConfiguration() {
        cardView.backgroundColor = .white
        cardView.layer.cornerRadius = 12
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowOpacity = 0.2
        cardView.layer.shadowOffset = CGSize(width: 0, height: 2)
        cardView.layer.shadowRadius = 4
        cardView.layer.masksToBounds = false
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true
    }

}

import UIKit

class HomeHeaderView: UICollectionReusableView {
    static let reuseIdentifier = "HomeHeaderView"

    private let logoView = LogoView()
    private let userNameLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        // Configure logoImageView
        addSubview(logoView)

        // Configure userNameLabel
        userNameLabel.font = .systemFont(ofSize: 18, weight: .bold)
        userNameLabel.textColor = .black
        addSubview(userNameLabel)
    }

    private func setupConstraints() {
        logoView.translatesAutoresizingMaskIntoConstraints = false
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            logoView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            logoView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            logoView.heightAnchor.constraint(equalToConstant: 40),
            logoView.widthAnchor.constraint(equalToConstant: 40),

            userNameLabel.centerYAnchor.constraint(equalTo: logoView.centerYAnchor),
            userNameLabel.leadingAnchor.constraint(equalTo: logoView.trailingAnchor, constant: 8),
            userNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }

    func configure(userName: String) {
        userNameLabel.text = userName
    }
}

import UIKit

class LogoView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    private func setupView() {
        // Define the size of the circles and the dot
        let outerCircleDiameter: CGFloat = 40
        let innerCircleDiameter: CGFloat = 19

        // Create the outer circle (border)
        let outerCircle = UIView()
        outerCircle.backgroundColor = .clear
        outerCircle.layer.borderColor = UIColor(red: 32/255.0, green: 43/255.0, blue: 71/255.0, alpha: 1.0).cgColor
        outerCircle.layer.borderWidth = 6 // Adjusted to fit the smaller size
        outerCircle.layer.cornerRadius = outerCircleDiameter / 2
        outerCircle.translatesAutoresizingMaskIntoConstraints = false
        addSubview(outerCircle)

        NSLayoutConstraint.activate([
            outerCircle.centerXAnchor.constraint(equalTo: centerXAnchor),
            outerCircle.centerYAnchor.constraint(equalTo: centerYAnchor),
            outerCircle.widthAnchor.constraint(equalToConstant: outerCircleDiameter),
            outerCircle.heightAnchor.constraint(equalToConstant: outerCircleDiameter)
        ])

        // Create the inner circle (filled)
        let innerCircle = UIView()
        innerCircle.backgroundColor = UIColor(red: 11/255.0, green: 193/255.0, blue: 176/255.0, alpha: 1.0)

        innerCircle.layer.cornerRadius = innerCircleDiameter / 2
        innerCircle.translatesAutoresizingMaskIntoConstraints = false
        addSubview(innerCircle)

        NSLayoutConstraint.activate([
            innerCircle.centerXAnchor.constraint(equalTo: centerXAnchor),
            innerCircle.centerYAnchor.constraint(equalTo: centerYAnchor),
            innerCircle.widthAnchor.constraint(equalToConstant: innerCircleDiameter),
            innerCircle.heightAnchor.constraint(equalToConstant: innerCircleDiameter)
        ])

//        // Create the dot on the outer circle
//        let dot = UIView()
//        dot.backgroundColor = UIColor.red
//        dot.layer.cornerRadius = dotDiameter / 2
//        dot.translatesAutoresizingMaskIntoConstraints = false
//        addSubview(dot)
//
//        NSLayoutConstraint.activate([
//            dot.centerXAnchor.constraint(equalTo: outerCircle.centerXAnchor, constant: -outerCircleDiameter / 4),
//            dot.centerYAnchor.constraint(equalTo: outerCircle.centerYAnchor, constant: -outerCircleDiameter / 4),
//            dot.widthAnchor.constraint(equalToConstant: dotDiameter),
//            dot.heightAnchor.constraint(equalToConstant: dotDiameter)
//        ])
//
//        // Create a mask to cut the outer circle
//        let maskLayer = CAShapeLayer()
//        let outerCirclePath = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: outerCircleDiameter, height: outerCircleDiameter))
//        let dotPath = UIBezierPath(ovalIn: CGRect(x: outerCircleDiameter / 2 - dotDiameter / 2, y: -dotDiameter / 2, width: dotDiameter, height: dotDiameter))
//        outerCirclePath.append(dotPath)
//        outerCirclePath.usesEvenOddFillRule = true
//        maskLayer.path = outerCirclePath.cgPath
//        outerCircle.layer.mask = maskLayer
    }
}
