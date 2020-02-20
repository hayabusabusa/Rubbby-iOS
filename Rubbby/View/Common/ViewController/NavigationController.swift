//
//  NavigationController.swift
//  Rubbby
//
//  Created by Yamada Shunya on 2020/02/17.
//  Copyright © 2020 Shunya Yamada. All rights reserved.
//

import UIKit

final class NavigationController: UINavigationController {

    // MARK: Overrides

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        setupBackButton(viewController)
        super.pushViewController(viewController, animated: animated)
    }

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupAppearance()
    }
}

// MARK: - Setup

extension NavigationController {

    private func setupAppearance() {
        view.backgroundColor = .white
        navigationBar.isTranslucent = false
        navigationBar.tintColor = .primary
        navigationBar.barTintColor = .navigation
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.primary]
    }
}

// MARK: - Private

extension NavigationController {

    private func setupBackButton(_ viewController: UIViewController) {
        let backButtonItem = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
        viewController.navigationItem.leftBarButtonItem = backButtonItem
    }
}
