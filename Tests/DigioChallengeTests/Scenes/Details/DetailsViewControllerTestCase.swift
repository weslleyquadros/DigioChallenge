//
//  DetailsViewControllerTestCase.swift
//  DigioChallengeTests
//
//  Created by Weslley Tavares de Aguiar e Quadros on 20/08/24.
//

import XCTest
@testable import DigioChallenge

class DetailsViewControllerTestCase: XCTestCase {

    var viewController: DetailsViewController!
    var mockDetailsView: MockDetailsView!
    var mockDetailModel: ProductDetailModel!

    override func setUp() {
        super.setUp()
        mockDetailModel = ProductDetailModel(
            title: "Title",
            imageURL: "http://test.com/image.jpg",
            description: "Description"
        )
        viewController = DetailsViewController(model: mockDetailModel)
        mockDetailsView = MockDetailsView()

        let navigationController = UINavigationController(rootViewController: viewController)
        viewController.loadViewIfNeeded()
        viewController.mainView = mockDetailsView
        UIApplication.shared.windows.first?.rootViewController = navigationController
        viewController.viewDidLoad()
    }

    func testViewDidLoadConfiguresView() {
        XCTAssertEqual(mockDetailsView.configureCalledWithModel?.title, mockDetailModel.title)
        XCTAssertEqual(mockDetailsView.configureCalledWithModel?.imageURL, mockDetailModel.imageURL)
        XCTAssertEqual(mockDetailsView.configureCalledWithModel?.description, mockDetailModel.description)
    }

    func testNavigationBarTintColor() {
        XCTAssertEqual(viewController.navigationController?.navigationBar.tintColor, AppStyle.Colors.tealColor)
    }
}

class MockDetailsView: DetailsView {
    var configureCalledWithModel: ProductDetailModel?

    override func configure(withModel model: ProductDetailModel) {
        self.configureCalledWithModel = model
    }
}
