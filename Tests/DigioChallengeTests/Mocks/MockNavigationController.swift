//
//  MockNavigationController.swift
//  DigioChallengeTests
//
//  Created by Weslley Tavares de Aguiar e Quadros on 21/08/24.
//

import UIKit

class MockNavigationController: UINavigationController {

    var pushedViewController: UIViewController?

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: animated)
        pushedViewController = viewController
    }
}
