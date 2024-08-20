//
//  MockMainCoordinatorDelegate.swift
//  DigioChallengeTests
//
//  Created by Weslley Tavares de Aguiar e Quadros on 20/08/24.
//

import Foundation
@testable import DigioChallenge

class MockMainCoordinatorDelegate: MainCoordinatorDelegate {
    var navigationAction: CoordinatorAction?

    func navigation(action: CoordinatorAction) {
        navigationAction = action
    }
}
