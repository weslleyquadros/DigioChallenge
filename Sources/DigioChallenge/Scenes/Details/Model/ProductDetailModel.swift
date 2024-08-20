//
//  ProductDetailModel.swift
//  DigioChallenge
//
//  Created by Weslley Tavares de Aguiar e Quadros on 20/08/24.
//

import Foundation

// MARK: - ProductDetailModel

struct ProductDetailModel {
    let title: String
    let imageURL: String
    let description: String

    init(title: String,
         imageURL: String,
         description: String) {
        self.title = title
        self.imageURL = imageURL
        self.description = description
    }
}
