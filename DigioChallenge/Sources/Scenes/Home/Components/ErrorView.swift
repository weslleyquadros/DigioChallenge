//
//  ErrorView.swift
//  DigioChallenge
//
//  Created by Weslley Tavares de Aguiar e Quadros on 19/08/24.
//

import UIKit

final class ErrorView: UIView {

    internal let messageLabel: UILabel = {
        let label = UILabel()
        label.text = LocalizedString.genericError.localized
        label.textColor = AppStyle.Colors.primary
        label.font = AppStyle.Fonts.regular(size: 18)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    internal let retryButton: UIButton = {
        let button = UIButton()
        button.setImage(AppStyle.Assets.reloadIcon, for: .normal)
        button.tintColor = AppStyle.Colors.primary
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    internal func setRetryAction(target: Any, action: Selector) {
        retryButton.addTarget(target, action: action, for: .touchUpInside)
    }
}

extension ErrorView: CodeView {

    internal func buildViewHierarchy() {
        addSubview(retryButton)
        addSubview(messageLabel)
    }

    internal func setupConstraints() {
        retryButton.anchor(width: 60,
                           height: 60,
                           centerX: centerXAnchor,
                           centerY: centerYAnchor)

        messageLabel.anchor(top: retryButton.bottomAnchor,
                            leading: leadingAnchor,
                            trailing: trailingAnchor,
                            paddingTop: 20,
                            paddingLeading: 20,
                            paddingTrailing: 20)
    }
}
