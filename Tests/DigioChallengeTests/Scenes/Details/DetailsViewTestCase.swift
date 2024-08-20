//
//  DetailsViewTestCase.swift
//  DigioChallenge
//
//  Created by Weslley Tavares de Aguiar e Quadros on 18/08/24.
//

import XCTest
@testable import DigioChallenge

final class DetailsViewTestCase: XCTestCase {

    var sut: DetailsView!

    override func setUp() {
        sut = DetailsView()
    }

    override func tearDown() {
        sut = nil
    }

    func testDefaultValues() {
        XCTAssertEqual(sut.titleLabel.text, nil)
        XCTAssertEqual(sut.descriptionLabel.text, nil)
        XCTAssertEqual(sut.imageView.image, nil)
        XCTAssertEqual(sut.backgroundColor, AppStyle.Colors.tealColor)
    }

    func testConfigureValues() {
        sut.configure(withModel: ProductDetailModel(title: "ProductName", imageURL: "image://teste", description: "Description"))
        XCTAssertEqual(sut.titleLabel.text, "ProductName")
        XCTAssertEqual(sut.descriptionLabel.text, "Description")
    }

}
