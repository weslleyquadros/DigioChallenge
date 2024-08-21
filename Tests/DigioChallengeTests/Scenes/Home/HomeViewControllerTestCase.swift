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

    func testHomeViewControllerInit() {
        let viewController = HomeViewController(viewModel: mockViewModel)
        
        XCTAssertNotNil(viewController.viewModel)
        XCTAssertEqual(viewController.viewModel.sections.count, 0)
    }

    func testViewDidLoad() {
        XCTAssertNotNil(sut.collectionView)
        XCTAssertNotNil(sut.errorView)
        XCTAssertTrue(sut.view.subviews.contains(sut.collectionView))
        XCTAssertFalse(sut.view.subviews.contains(sut.errorView))
    }
    
    func testUpdateUI() {
        mockViewModel.homeData = HomeModelDummy.makeHomeModel()

        sut.updateUI()

        XCTAssertTrue(sut.collectionView.visibleCells.allSatisfy { !$0.contentView.isShimmering })
        XCTAssertTrue(sut.collectionView.visibleSupplementaryViews(ofKind: UICollectionView.elementKindSectionHeader).allSatisfy { !$0.isShimmering })
    }

    func testSizeForItemAt() {
        mockViewModel.sections = HomeModelDummy.makeHomeSections()
        let expectedSizes = [
            CGSize(width: sut.collectionView.bounds.width, height: 180),
            CGSize(width: sut.collectionView.bounds.width - 48, height: 100),
            CGSize(width: sut.collectionView.bounds.width, height: 150)
        ]

        for (index, expectedSize) in expectedSizes.enumerated() {
            let size = sut.collectionView(
                sut.collectionView,
                layout: sut.collectionView.collectionViewLayout,
                sizeForItemAt: IndexPath(row: 0, section: index)
            )
            XCTAssertEqual(size, expectedSize)
        }
    }

    func testReferenceSizeForHeaderInSection() {
        mockViewModel.sections = HomeModelDummy.makeHomeSections()
        let expectedSizes = [
            CGSize(width: sut.collectionView.bounds.width, height: 100),
            CGSize(width: sut.collectionView.bounds.width, height: 65),
            CGSize(width: sut.collectionView.bounds.width, height: 65)
        ]

        for (index, expectedSize) in expectedSizes.enumerated() {
            let size = sut.collectionView(
                sut.collectionView,
                layout: sut.collectionView.collectionViewLayout,
                referenceSizeForHeaderInSection: index
            )
            XCTAssertEqual(size, expectedSize)
        }
    }

    func testViewForSupplementaryElementOfKind() {
        mockViewModel.sections = HomeModelDummy.makeHomeSections()
        sut.collectionView.reloadData()
        sut.collectionView.layoutIfNeeded()

        let headerView = sut.collectionView(
            sut.collectionView,
            viewForSupplementaryElementOfKind: UICollectionView.elementKindSectionHeader,
            at: IndexPath(row: 0, section: 0)
        ) as? HomeHeaderView

        XCTAssertNotNil(headerView)
        XCTAssertEqual(headerView?.userNameLabel.text, LocalizedString.homeTitle.localized)
    }


    func testDidSelectItemAt() {
        mockViewModel.sections = HomeModelDummy.makeHomeSections()
        mockViewModel.homeData = HomeModelDummy.makeHomeModel()
        
        sut.collectionView(
            sut.collectionView,
            didSelectItemAt: IndexPath(row: 0, section: 1)
        )
        
        if case let .details(model) = mockDelegate.navigationAction {
            XCTAssertEqual(model.title, mockViewModel.homeData?.cash.title)
            XCTAssertEqual(model.imageURL, mockViewModel.homeData?.cash.bannerURL)
            XCTAssertEqual(model.description, mockViewModel.homeData?.cash.description)
        } else {
            XCTFail("Expected .details action")
        }
    }

    func testSetupBindings_onSuccess() {
        sut.viewDidLoad()
        
        mockViewModel.onSuccess?()
        
        XCTAssertTrue(sut.collectionView.visibleCells.allSatisfy { !$0.contentView.isShimmering })
    }

    func testSetupBindings_onError() {
        sut.viewDidLoad()

        mockViewModel.onError?(HomeDataError.fetchFailed)
        
        XCTAssertTrue(sut.view.subviews.contains(sut.errorView))
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
