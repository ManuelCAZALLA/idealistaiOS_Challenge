//
//  MainViewControllerWrapper.swift
//  idealistaiOS_Challenge
//
//  Created by Manuel Cazalla Colmenero on 18/5/25.
//

import SwiftUI
import UIKit

struct MainViewControllerRepresentable: UIViewControllerRepresentable {
    
    
    func makeUIViewController(context: Context) -> MainViewController {
        return MainViewController(nibName: "Main", bundle: nil)
    }

   func updateUIViewController(_ uiViewController: MainViewController, context: Context) {
      
    }
}
