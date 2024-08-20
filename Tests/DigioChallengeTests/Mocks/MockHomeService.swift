//
//  MockHomeService.swift
//  DigioChallengeTests
//
//  Created by Weslley Tavares de Aguiar e Quadros on 20/08/24.
//

import XCTest
@testable import DigioChallenge

class MockHomeService: HomeServiceProtocol {
    var fetchHomeDataCalled = false
    var fetchHomeDataWithError = false

    func fetchHomeData(completion: @escaping (Result<HomeModel, Error>) -> Void) {
        fetchHomeDataCalled = true
        if fetchHomeDataWithError {
            completion(
                .failure(
                    NSError(
                        domain: "TestErrorDomain",
                        code: 1,
                        userInfo: [NSLocalizedDescriptionKey: "Simulated error"]
                    )
                )
            )
        } else {
            completion(.success(HomeModelDummy.makeHomeModel()))
        }
    }
}
