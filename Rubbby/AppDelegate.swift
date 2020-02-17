//
//  AppDelegate.swift
//  Rubbby
//
//  Created by Yamada Shunya on 2020/02/13.
//  Copyright © 2020 Shunya Yamada. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // NOTE: Enable IQKeyboardManager
        IQKeyboardManager.shared.enable = true
        
        // NOTE: Setup RootViewController
        setupRootViewController()
        return true
    }
}

// MARK: Root ViewController

extension AppDelegate {

    private func setupRootViewController() {
        let vc = NavigationController(rootViewController: InputSentenceViewController.instantiate())
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        window.rootViewController = vc
        window.makeKeyAndVisible()
    }
}
