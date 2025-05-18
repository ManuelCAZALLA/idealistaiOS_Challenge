//
//  SceneDelegate.swift
//  idealistaiOS_Challenge
//
//  Created by Manuel Cazalla Colmenero on 13/2/25.
//

import UIKit
import SwiftUI

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
        let loginView = LoginView()
        let hostingController = UIHostingController(rootView: loginView)
        hostingController.modalPresentationStyle = .fullScreen
        
        window?.rootViewController = hostingController
    }

}
