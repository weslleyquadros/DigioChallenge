//
//  DigioCoordinatorTestCase.swift
//  DigioChallengeTests
//
//  Created by Weslley Tavares de Aguiar e Quadros on 21/08/24.
//

import XCTest
@testable import DigioChallenge

class DigioCoordinatorTests: XCTestCase {

    var coordinator: DigioCoordinator!
    var navigationController: MockNavigationController!

    override func setUp() {
        super.setUp()
        navigationController = MockNavigationController()
        coordinator = DigioCoordinator(rootViewController: navigationController)
    }

    override func tearDown() {
        coordinator = nil
        navigationController = nil
        super.tearDown()
    }

    func testStart() {
        // Given

        // When
        coordinator.start()

        // Then
        XCTAssertTrue(navigationController.pushedViewController is HomeViewController)

        let homeVC = navigationController.pushedViewController as? HomeViewController
        XCTAssertNotNil(homeVC)
        XCTAssertTrue(homeVC?.delegate === coordinator)
    }

    func testNavigationToDetails() {
        // Given
        let productDetailModel = ProductDetailModel(
            title: "Test",
            imageURL: "https://test.com",
            description: "Test Description"
        )
        let action = CoordinatorAction.details(model: productDetailModel)

        // When
        coordinator.navigation(action: action)

        // Then
        XCTAssertTrue(navigationController.pushedViewController is DetailsViewController)
        let detailsVC = navigationController.pushedViewController as? DetailsViewController
        XCTAssertEqual(detailsVC?.detailModel.title, productDetailModel.title)
        XCTAssertEqual(detailsVC?.detailModel.imageURL, productDetailModel.imageURL)
        XCTAssertEqual(detailsVC?.detailModel.description, productDetailModel.description)
    }

    func testDigioCoordinatorEquality() {
        // Given
        let navController1 = UINavigationController()
        let navController2 = UINavigationController()

        let coordinator1 = DigioCoordinator(rootViewController: navController1)
        let coordinator2 = DigioCoordinator(rootViewController: navController1)
        let coordinator3 = DigioCoordinator(rootViewController: navController2)

        // When & Then
        XCTAssertEqual(coordinator1,
                       coordinator2,
                       "Coordinators with the same rootViewController should be equal.")
        XCTAssertNotEqual(coordinator1,
                          coordinator3,
                          "Coordinators with different rootViewControllers should not be equal.")
    }
}
