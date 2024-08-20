//
//  UILabel+ NSAttributedString.swift
//  DigioChallenge
//
//  Created by Weslley Tavares de Aguiar e Quadros on 19/08/24.
//

import UIKit

extension UILabel {
    func setAttributedText(with string: String) {
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
            value: AppStyle.Colors.primary,
            range: firstWordRange
        )

        // Define the range for the subsequent words
        var location = words[0].count + 1 // Add 1 to account for the space after the first word
        for word in words.dropFirst() {
            let length = word.count
            let range = NSRange(location: location, length: length)
            attributedString.addAttribute(
                .foregroundColor,
                value: AppStyle.Colors.secondary,
                range: range
            )
            location += length + 1 // Add 1 to account for the space between words
        }

        self.attributedText = attributedString
    }
}
