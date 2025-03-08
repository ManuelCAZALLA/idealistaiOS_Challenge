//
//  SplasViewController.swift
//  idealistaiOS_Challenge
//
//  Created by Manuel Cazalla Colmenero on 8/3/25.
//

import UIKit

class SplashViewController: UIViewController {
    
    private var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       if let launchScreen = UIStoryboard(name: "LaunchScreen", bundle: nil).instantiateInitialViewController() {
            addChild(launchScreen)
            launchScreen.view.frame = view.frame
            view.addSubview(launchScreen.view)
            launchScreen.didMove(toParent: self)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.showMainScreen()
        }
    }
    
    private func showMainScreen() {
        let mainVC = MainViewController(nibName: "Main", bundle: nil)
        let navigationController = UINavigationController(rootViewController: mainVC)
        navigationController.modalPresentationStyle = .fullScreen
        
        guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else { return }
        sceneDelegate.window?.rootViewController = navigationController
    }
}
