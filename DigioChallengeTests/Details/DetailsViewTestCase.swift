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
        XCTAssertEqual(sut.title.text, nil)
        XCTAssertEqual(sut.descriptionText.text, nil)
        XCTAssertEqual(sut.backgroundColor, AppStyle.Colors.tealColor)
    }

    func testConfigureValues() {
        sut.configure(name: "Name", description: "Description")
        XCTAssertEqual(sut.title.text, "Name")
        XCTAssertEqual(sut.descriptionText.text, "Description")
    }

}
