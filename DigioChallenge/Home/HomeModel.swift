//
//  HomeModel.swift
//  DigioChallenge
//
//  Created by Weslley Tavares de Aguiar e Quadros on 18/08/24.
//

import Foundation

// MARK: - HomeModel
struct HomeModel: Decodable {
    let spotlight: [Spotlight]
    let products: [Product]
    let cash: Cash
}

// MARK: - Cash
struct Cash: Decodable {
    let title: String
    let bannerURL: String
    let description: String
}

// MARK: - Product
struct Product: Decodable {
    let name: String
    let imageURL: String
    let description: String
}

// MARK: - Spotlight
struct Spotlight: Decodable {
    let name: String
    let bannerURL: String
    let description: String
}

enum HomeSection {
    case spotlight([Spotlight])
    case products([Product])
    case cash(Cash)
}
