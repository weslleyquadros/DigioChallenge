//
//  HomeDigioCashCell.swift
//  DigioChallenge
//
//  Created by Weslley Tavares de Aguiar e Quadros on 18/08/24.
//

import UIKit

final class HomeDigioCashCell: UICollectionViewCell, CodeView {
    
    static let reuseIdentifier = "HomeDigioCashCell"
    
    private let imageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with cash: Cash) {
        imageView.loadImage(from: cash.bannerURL)
    }
}

//MARK: - CodeView

extension HomeDigioCashCell {
    func buildViewHierarchy() {
        contentView.addSubview(imageView)
    }

    func setupConstraints() {
        imageView.anchor(
            top: contentView.topAnchor,
            leading: contentView.leadingAnchor,
            bottom: contentView.bottomAnchor,
            trailing: contentView.trailingAnchor
        )
    }

    func setupAdditionalConfiguration() {
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        imageView.contentMode = .scaleToFill
    }
}
