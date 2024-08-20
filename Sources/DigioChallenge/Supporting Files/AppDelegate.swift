//
//  AppDelegate.swift
//  DigioChallenge
//
//  Created by Weslley Tavares de Aguiar e Quadros on 18/08/24.
//
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var mainCoordinator: DigioCoordinator?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        let navController = UINavigationController()

        mainCoordinator = DigioCoordinator(rootViewController: navController)
        mainCoordinator?.start()

        window?.rootViewController = navController
        window?.makeKeyAndVisible()

        return true
    }
}
