//
//  HomeSpotlightItemCell.swift
//  DigioChallenge
//
//  Created by Weslley Tavares de Aguiar e Quadros on 18/08/24.
//

import UIKit

final class HomeSpotlightItemCell: UICollectionViewCell, CodeView {

    static let reuseIdentifier = "HomeCardItemCell"

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        return imageView
    }()

    private lazy var cardView: UIView = {
        let cardView = UIView()
        cardView.backgroundColor = .white
        return cardView
    }()

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

// MARK: - CodeView

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
