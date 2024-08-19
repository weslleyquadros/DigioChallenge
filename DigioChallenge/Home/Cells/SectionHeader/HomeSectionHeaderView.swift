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
        label.font = UIFont(name: "ProximaNova-Bold", size: 18)
        label.textColor = UIColor(red: 32/255.0, green: 43/255.0, blue: 71/255.0, alpha: 1.0)
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

//MARK: - CodeView

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

extension UILabel {
    func setAttributedText(with string: String) {
        let defaultColor = UIColor(red: 32/255.0, green: 43/255.0, blue: 71/255.0, alpha: 1.0)
        let secondaryColor = UIColor(red: 141/255.0, green: 141/255.0, blue: 141/255.0, alpha: 1.0)

        let words = string.split(separator: " ")
        
        // Check if there is more than one word
        guard words.count > 1 else {
            self.text = string
            return
        }
        
        let attributedString = NSMutableAttributedString(string: string)
        
        // Define the range for the first word
        let firstWordRange = NSRange(location: 0, length: words[0].count)
        attributedString.addAttribute(
            .foregroundColor,
            value: defaultColor,
            range: firstWordRange
        )
        
        // Define the range for the subsequent words
        var location = words[0].count + 1 // Add 1 to account for the space after the first word
        for word in words.dropFirst() {
            let length = word.count
            let range = NSRange(location: location, length: length)
            attributedString.addAttribute(
                .foregroundColor,
                value: secondaryColor,
                range: range
            )
            location += length + 1 // Add 1 to account for the space between words
        }
        
        self.attributedText = attributedString
    }
}
