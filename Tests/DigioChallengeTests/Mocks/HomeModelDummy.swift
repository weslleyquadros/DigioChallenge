//
//  HomeModelDummy.swift
//  DigioChallengeTests
//
//  Created by Weslley Tavares de Aguiar e Quadros on 20/08/24.
//

import Foundation
@testable import DigioChallenge

struct HomeModelDummy {

    static func makeHomeModel() -> HomeModel {
        return HomeModel(
            spotlight: makeSpotlights(),
            products: makeProducts(),
            cash: makeCash()
        )
    }

    static func makeSpotlights() -> [Spotlight] {
        return [
            Spotlight(name: "Spotlight 1",
                      bannerURL: "https://test.com/spotlight1.png",
                      description: "Description for Spotlight 1"),
            Spotlight(name: "Spotlight 2",
                      bannerURL: "https://test.com/spotlight2.png",
                      description: "Description for Spotlight 2"),
            Spotlight(name: "Spotlight 3",
                      bannerURL: "https://test.com/spotlight3.png",
                      description: "Description for Spotlight 3")
        ]
    }

    static func makeProducts() -> [Product] {
        return [
            Product(name: "Product 1",
                    imageURL: "https://test.com/product1.png",
                    description: "Description for Product 1"),
            Product(name: "Product 2",
                    imageURL: "https://test.com/product2.png",
                    description: "Description for Product 2"),
            Product(name: "Product 3",
                    imageURL: "https://test.com/product3.png",
                    description: "Description for Product 3")
        ]
    }

    static func makeCash() -> Cash {
        return Cash(title: "digio Cash",
                    bannerURL: "https://test.com/cash.png",
                    description: "Description for digio Cash")
    }

    static func makeHomeSections() -> [HomeSection] {
        return [
            .spotlight(makeSpotlights()),
            .products(makeProducts()),
            .cash(makeCash())
        ]
    }
}
