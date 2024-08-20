//
//  DetailsView.swift
//  DigioChallenge
//
//  Created by Weslley Tavares de Aguiar e Quadros on 18/08/24.
//

import UIKit

class DetailsView: UIView {
    
    lazy var title: UILabel = {
        var text = UILabel()
        text.numberOfLines = 0
        text.font = AppStyle.Fonts.bold(size: 25)
        text.textColor = .white
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()

    lazy var whiteView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var descriptionText: UILabel = {
        var text = UILabel()
        text.numberOfLines = 0
        text.textColor = .darkGray
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(name: String, description: String) {
        title.text = name
        descriptionText.text = description
    }

}

extension DetailsView: CodeView {
    func setupAdditionalConfiguration() {
        self.backgroundColor = AppStyle.Colors.tealColor
    }

    func buildViewHierarchy() {
        addSubview(title)
        addSubview(whiteView)
        whiteView.addSubview(descriptionText)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            title.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),

            whiteView.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 30),
            whiteView.leadingAnchor.constraint(equalTo: leadingAnchor),
            whiteView.trailingAnchor.constraint(equalTo: trailingAnchor),
            whiteView.bottomAnchor.constraint(equalTo: bottomAnchor),

            descriptionText.topAnchor.constraint(equalTo: whiteView.topAnchor, constant: 30),
            descriptionText.leadingAnchor.constraint(equalTo: whiteView.leadingAnchor, constant: 30),
            descriptionText.trailingAnchor.constraint(equalTo: whiteView.trailingAnchor, constant: -30),
            descriptionText.bottomAnchor.constraint(lessThanOrEqualTo: whiteView.bottomAnchor)
        ])
    }
}
