//
//  HomeSectionHeaderView.swift
//  DigioChallenge
//
//  Created by Weslley Tavares de Aguiar e Quadros on 18/08/24.
//

import UIKit

class HomeSectionHeaderView: UICollectionReusableView, CodeView {

    static let reuseIdentifier = "HomeSectionHeaderView"

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = AppStyle.Fonts.bold(size: 18)
        label.textColor = AppStyle.Colors.primary
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with title: String) {
        titleLabel.setAttributedText(with: title)
    }
}

// MARK: - CodeView

extension HomeSectionHeaderView {
    func setupConstraints() {
        titleLabel.anchor(
            top: topAnchor,
            leading: leadingAnchor,
            bottom: bottomAnchor,
            trailing: trailingAnchor,
            paddingLeading: 24,
            paddingTrailing: 24
        )
    }

    func buildViewHierarchy() {
        addSubview(titleLabel)
    }
}
