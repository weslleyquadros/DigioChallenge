//
//  MockNetworkService.swift
//  DigioChallengeTests
//
//  Created by Weslley Tavares de Aguiar e Quadros on 21/08/24.
//

import Foundation
@testable import DigioChallenge

class MockNetworkService: RequestProvider {
    var mockResult: (Response)?
    func make(request: RouterProtocol, completion: @escaping (Response) -> Void) {
        if let result = mockResult {
            completion(result)
        }
    }

}
