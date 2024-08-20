//
//  MockHomeViewModel.swift
//  DigioChallengeTests
//
//  Created by Weslley Tavares de Aguiar e Quadros on 20/08/24.
//

import Foundation
@testable import DigioChallenge

enum HomeDataError: Error {
    case fetchFailed
}

class MockHomeViewModel: HomeViewModelProtocol {
    var homeData: HomeModel?
    var sections: [HomeSection] = []
    var onSuccess: (() -> Void)?
    var onError: ((Error) -> Void)?
    var fetchHomeDataCalled = false
    var fetchHomeDataWithError = false

    func fetchHomeData() {
        fetchHomeDataCalled = true
        if fetchHomeDataWithError {
            onError?(HomeDataError.fetchFailed)
        } else {
            onSuccess?()
        }
    }
}
