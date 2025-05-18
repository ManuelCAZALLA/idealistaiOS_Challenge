//
//  SplasViewController.swift
//  idealistaiOS_Challenge
//
//  Created by Manuel Cazalla Colmenero on 8/3/25.
//

import UIKit

protocol SplashViewControllerDelegate: AnyObject {
    func didFinishSplashScreen()
}

class SplashViewController: UIViewController {
    
    weak var delegate: SplashViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let launchScreen = UIStoryboard(name: "LaunchScreen", bundle: nil).instantiateInitialViewController() {
            addChild(launchScreen)
            launchScreen.view.frame = view.frame
            view.addSubview(launchScreen.view)
            launchScreen.didMove(toParent: self)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.delegate?.didFinishSplashScreen()
        }
    }
}
