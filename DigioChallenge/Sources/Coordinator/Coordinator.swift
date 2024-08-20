//
//  Coordinator.swift
//  DigioChallenge
//
//  Created by Weslley Tavares de Aguiar e Quadros on 18/08/24.
//

import UIKit

enum CoordinatorAction {
    case details(model: ProductDetailModel)
}

protocol Coordinator {
    var rootViewController: UINavigationController { get set }
    func start()
}

protocol MainCoordinatorDelegate: AnyObject {
    func navigation(action: CoordinatorAction)
}

public class DigioCoordinator: Coordinator {

    public var rootViewController: UINavigationController

    public required init(rootViewController: UINavigationController) {
        self.rootViewController = rootViewController
    }

    public func start() {
        let controller = HomeViewController()
        controller.delegate = self
        rootViewController.pushViewController(controller, animated: true)
    }

}

extension DigioCoordinator: MainCoordinatorDelegate {
    func navigation(action: CoordinatorAction) {
        switch action {
        case let .details(model):
            let controller = DetailsViewController(model: model)
            rootViewController.pushViewController(controller, animated: true)
        }
    }
}
