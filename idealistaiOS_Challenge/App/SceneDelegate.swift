//
//  SceneDelegate.swift
//  idealistaiOS_Challenge
//
//  Created by Manuel Cazalla Colmenero on 13/2/25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window.windowScene = windowScene
        
        let viewController = MainViewController(nibName: "Main", bundle: nil)
        viewController.modalPresentationStyle = .fullScreen
        
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.modalPresentationStyle = .fullScreen
        
        window.rootViewController = navigationController
        window.backgroundColor = .systemBackground
        window.overrideUserInterfaceStyle = .light
        
        self.window = window
        window.makeKeyAndVisible()
    }

}

