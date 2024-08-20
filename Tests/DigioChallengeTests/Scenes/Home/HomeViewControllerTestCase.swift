//
//  HomeViewControllerTestCase.swift
//  DigioChallengeTests
//
//  Created by Weslley Tavares de Aguiar e Quadros on 20/08/24.
//

import XCTest
@testable import DigioChallenge

class HomeViewControllerTestCase: XCTestCase {

    var sut: HomeViewController!
    var mockViewModel: MockHomeViewModel!
    var mockDelegate: MockMainCoordinatorDelegate!

    override func setUp() {
        super.setUp()

        mockViewModel = MockHomeViewModel()
        mockDelegate = MockMainCoordinatorDelegate()

        sut = HomeViewController(viewModel: mockViewModel)
        sut.delegate = mockDelegate

        _ = sut.view
    }

    override func tearDown() {
        sut = nil
        mockViewModel = nil
        mockDelegate = nil
        super.tearDown()
    }

    func testViewDidLoad() {
        XCTAssertNotNil(sut.collectionView)
        XCTAssertNotNil(sut.errorView)
        XCTAssertTrue(sut.view.subviews.contains(sut.collectionView))
        XCTAssertFalse(sut.view.subviews.contains(sut.errorView))
    }

    func testShowErrorView() {
        mockViewModel.fetchHomeDataWithError = true
        sut.viewDidLoad()

        XCTAssertTrue(sut.view.subviews.contains(sut.errorView))

        let constraints = sut.view.constraints
        XCTAssertTrue(constraints.contains { constraint in
            constraint.firstAnchor == sut.errorView.topAnchor &&
            constraint.secondAnchor == sut.view.topAnchor
        })
    }

    func testRemoveErrorView() {
        sut.showErrorView()
        sut.removeErrorView()

        XCTAssertFalse(sut.view.subviews.contains(sut.errorView))
    }

    func testRetryButtonTapped() {
        sut.showErrorView()
        sut.retryButtonTapped()

        XCTAssertFalse(sut.view.subviews.contains(sut.errorView))
        XCTAssertTrue(mockViewModel.fetchHomeDataCalled)
    }

    func testCollectionViewDataSource() {
        mockViewModel.homeData = HomeModelDummy.makeHomeModel()
        mockViewModel.sections = HomeModelDummy.makeHomeSections()

        sut.collectionView.reloadData()

        XCTAssertEqual(sut.collectionView.numberOfSections, 3)
        XCTAssertEqual(sut.collectionView.numberOfItems(inSection: 0), 1)
        XCTAssertEqual(sut.collectionView.numberOfItems(inSection: 1), 1)
        XCTAssertEqual(sut.collectionView.numberOfItems(inSection: 2), 1)
    }

    func testClickCellDelegate() {
        sut.clickCell(with: ProductDetailModel(
            title: "Test",
            imageURL: "URLTest",
            description: "Description"
        ))

        if case let .details(model) = mockDelegate.navigationAction {
            XCTAssertEqual(model.title, "Test")
            XCTAssertEqual(model.imageURL, "URLTest")
            XCTAssertEqual(model.description, "Description")
        } else {
            XCTFail("Expected .details action")
        }
    }
}
