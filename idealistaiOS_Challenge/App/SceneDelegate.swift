//
//  SceneDelegate.swift
//  idealistaiOS_Challenge
//
//  Created by Manuel Cazalla Colmenero on 13/2/25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate, SplashViewControllerDelegate {

    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window.windowScene = windowScene
        
        let splashViewController = SplashViewController()
        splashViewController.delegate = self
        window.rootViewController = splashViewController
        
        self.window = window
        window.makeKeyAndVisible()
    }

    func didFinishSplashScreen() {
        let mainVC = MainViewController(nibName: "Main", bundle: nil)
        let navigationController = UINavigationController(rootViewController: mainVC)
        navigationController.modalPresentationStyle = .fullScreen
        
        window?.rootViewController = navigationController
    }
}
