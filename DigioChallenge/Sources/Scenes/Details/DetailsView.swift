//
//  DetailsView.swift
//  DigioChallenge
//
//  Created by Weslley Tavares de Aguiar e Quadros on 18/08/24.
//

import UIKit

final class DetailsView: UIView {

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = AppStyle.Fonts.bold(size: 28)
        label.textColor = AppStyle.Colors.primary
        return label
    }()

    private lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 24
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return view
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = AppStyle.Colors.secondary
        label.font = AppStyle.Fonts.light(size: 18)
        return label
    }()

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        return imageView
    }()

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(withModel model: ProductDetailModel) {
        titleLabel.setAttributedText(with: model.title)
        descriptionLabel.text = model.description
        imageView.loadImage(from: model.imageURL)
    }

}

extension DetailsView: CodeView {
    func setupAdditionalConfiguration() {
        self.backgroundColor = AppStyle.Colors.tealColor
    }

    func buildViewHierarchy() {
        addSubview(imageView)
        addSubview(contentView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
    }

    func setupConstraints() {

        imageView.anchor(
            top: topAnchor,
            leading: safeAreaLayoutGuide.leadingAnchor,
            trailing: safeAreaLayoutGuide.trailingAnchor,
            height: UIScreen.main.bounds.height * 0.4
        )

        contentView.anchor(
            top: imageView.bottomAnchor,
            leading: leadingAnchor,
            bottom: bottomAnchor,
            trailing: trailingAnchor,
            paddingTop: -30
        )

        titleLabel.anchor(
            top: contentView.topAnchor,
            leading: contentView.leadingAnchor,
            paddingTop: 24,
            paddingLeading: 24
        )

        descriptionLabel.anchor(
            top: titleLabel.bottomAnchor,
            leading: contentView.leadingAnchor,
            bottom: contentView.bottomAnchor,
            trailing: contentView.trailingAnchor,
            paddingTop: 48,
            paddingLeading: 24,
            paddingTrailing: 24,
            bottomRelation: .lessThanOrEqual
        )

    }
}
