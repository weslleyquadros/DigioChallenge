//
//  ErrorViewTestCase.swift
//  DigioChallenge
//
//  Created by Weslley Tavares de Aguiar e Quadros on 18/08/24.
//

import XCTest
@testable import DigioChallenge

final class ErrorViewTestCase: XCTestCase {

    var sut: ErrorView!

    override func setUp() {
        sut = ErrorView()
    }

    override func tearDown() {
        sut = nil
    }

    func testDefaultValues() throws {
        XCTAssertEqual(sut.messageLabel.text, "Erro ao acessar a tela, tente novamente")
    }

}
