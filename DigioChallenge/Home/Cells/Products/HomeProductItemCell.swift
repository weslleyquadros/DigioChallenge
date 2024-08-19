//
//  HomeProductItemCell.swift
//  DigioChallenge
//
//  Created by Weslley Tavares de Aguiar e Quadros on 18/08/24.
//

import UIKit

final class HomeProductItemCell: UICollectionViewCell, CodeView {
    
    static let reuseIdentifier = "HomeProductItemCell"
    
    private let imageView = UIImageView()
    private let cardView = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with product: Product) {
        imageView.loadImage(from: product.imageURL)
    }
}

//MARK: - CodeView

extension HomeProductItemCell {
    func buildViewHierarchy() {
        contentView.addSubviewFillingSuperview(cardView)
        cardView.addSubview(imageView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            cardView.widthAnchor.constraint(equalToConstant: 100),
            cardView.heightAnchor.constraint(equalToConstant: 100),
            imageView.centerYAnchor.constraint(equalTo: cardView.centerYAnchor),
            imageView.centerXAnchor.constraint(equalTo: cardView.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 50),
            imageView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func setupAdditionalConfiguration() {
        cardView.backgroundColor = .white
        cardView.clipsToBounds = true
        cardView.layer.cornerRadius = 16
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowOpacity = 0.2
        cardView.layer.shadowOffset = CGSize(width: 0, height: 2)
        cardView.layer.shadowRadius = 4
        cardView.layer.masksToBounds = false
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        cardView.translatesAutoresizingMaskIntoConstraints = false
    }
}
