//
//  HomeHeaderView.swift
//  DigioChallenge
//
//  Created by Weslley Tavares de Aguiar e Quadros on 19/08/24.
//

import UIKit

class HomeHeaderView: UICollectionReusableView, CodeView {

    static let reuseIdentifier = "HomeHeaderView"

    private let circleView = CircleView()
    private let userNameLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupAdditionalConfiguration() {
        userNameLabel.font = AppStyle.Fonts.bold(size: 18)
        userNameLabel.textColor = AppStyle.Colors.primary
    }

    func buildViewHierarchy() {
        addSubview(circleView)
        addSubview(userNameLabel)
    }

    func setupConstraints() {
        circleView.anchor(
            top: topAnchor,
            leading: leadingAnchor,
            paddingTop: 24,
            paddingLeading: 24,
            width: 40,
            height: 40
        )

        userNameLabel.anchor(
            leading: circleView.trailingAnchor,
            trailing: trailingAnchor,
            paddingLeading: 8,
            paddingTrailing: 24,
            centerY: circleView.centerYAnchor
        )
    }

    func configure(userName: String) {
        userNameLabel.text = userName
    }
}
