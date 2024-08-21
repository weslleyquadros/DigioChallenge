//
//  HomeServiceTestCase.swift
//  DigioChallengeTests
//
//  Created by Weslley Tavares de Aguiar e Quadros on 21/08/24.
//

import XCTest
@testable import DigioChallenge

class HomeServiceTestCase: XCTestCase {

    var service: HomeService!
    var mockNetworkService: MockNetworkService!

    override func setUp() {
        super.setUp()
        mockNetworkService = MockNetworkService()
        service = HomeService(networkService: mockNetworkService)
    }

    override func tearDown() {
        service = nil
        mockNetworkService = nil
        super.tearDown()
    }

    func testFetchHomeDataSuccess() {
        // Given
        let expectedModel = HomeModelDummy.makeHomeModel()
        let encodedData = try? JSONEncoder().encode(expectedModel)
        mockNetworkService.mockResult = Response(data: encodedData)
        let expectation = XCTestExpectation(description: "Completion called with success")

        // When
        service.fetchHomeData { result in
            // Then
            switch result {
            case .success(let model):
                XCTAssertEqual(model.spotlight.first?.name, expectedModel.spotlight.first?.name)
                XCTAssertEqual(model.products.first?.name, expectedModel.products.first?.name)
                XCTAssertEqual(model.cash.title, expectedModel.cash.title)
            case .failure:
                XCTFail("Expected success but got failure")
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)
    }

    func testFetchHomeDataFailureNoData() {
        // Given
        mockNetworkService.mockResult = Response(data: nil)

        let expectation = XCTestExpectation(description: "Completion called with failure")

        // When
        service.fetchHomeData { result in
            // Then
            switch result {
            case .success:
                XCTFail("Expected failure but got success")
            case .failure(let error as NSError):
                XCTAssertEqual(error.localizedDescription, "No data found.")
            default:
                XCTFail("Unexpected result")
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)
    }

    func testFetchHomeDataFailureDecodingError() {
        // Given
        let invalidJSONData = "Invalid JSON".data(using: .utf8)!
        mockNetworkService.mockResult = Response(data: invalidJSONData)
        let expectation = XCTestExpectation(description: "Completion called with failure")

        // When
        service.fetchHomeData { result in
            // Then
            switch result {
            case .success:
                XCTFail("Expected failure but got success")
            case .failure(let error):
                XCTAssertTrue(error is DecodingError)
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)
    }
}
