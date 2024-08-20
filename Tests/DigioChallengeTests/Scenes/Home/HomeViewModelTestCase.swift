//
//  HomeViewModelTestCase.swift
//  DigioChallengeTests
//
//  Created by Weslley Tavares de Aguiar e Quadros on 20/08/24.
//

import XCTest
@testable import DigioChallenge

class HomeViewModelTestCase: XCTestCase {

    var viewModel: HomeViewModel!
    var mockNetworkService: MockHomeService!

    override func setUp() {
        super.setUp()
        mockNetworkService = MockHomeService()
        viewModel = HomeViewModel(networkService: mockNetworkService)
    }

    override func tearDown() {
        viewModel = nil
        mockNetworkService = nil
        super.tearDown()
    }

    func testEmptyDataState() {
        XCTAssertNil(self.viewModel.homeData?.spotlight)
        XCTAssertNil(self.viewModel.homeData?.products)
        XCTAssertNil(self.viewModel.homeData?.cash)
    }

    func testFetchHomeDataSuccess() {
        mockNetworkService.fetchHomeDataWithError = false

        let expectation = XCTestExpectation(description: "Fetch home data")

        viewModel.onSuccess = {
            XCTAssertNotNil(self.viewModel.homeData)
            XCTAssertEqual(self.viewModel.sections.count, 3)
            expectation.fulfill()
        }

        viewModel.onError = { error in
            XCTFail("Expected success but got error: \(error)")
        }

        viewModel.fetchHomeData()

        wait(for: [expectation], timeout: 1.0)
    }

    func testFetchHomeDataError() {
        mockNetworkService.fetchHomeDataWithError = true

        let expectation = XCTestExpectation(description: "FetchHomeDataError")

        viewModel.onSuccess = {
            XCTFail("Expected error, but got success.")
        }

        viewModel.onError = { error in
            XCTAssertEqual((error as NSError).domain, "TestErrorDomain")
            XCTAssertEqual((error as NSError).code, 1)
            XCTAssertEqual((error as NSError).userInfo[NSLocalizedDescriptionKey] as? String, "Simulated error")
            expectation.fulfill()
        }

        viewModel.fetchHomeData()

        wait(for: [expectation], timeout: 1.0)
    }

}
