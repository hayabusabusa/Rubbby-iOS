//
//  ResultViewController.swift
//  Rubbby
//
//  Created by Yamada Shunya on 2020/02/18.
//  Copyright © 2020 Shunya Yamada. All rights reserved.
//

import UIKit

final class ResultViewController: DisposableViewController {

    // MARK: IBOutlet

    @IBOutlet private weak var tableView: UITableView!

    // MARK: Properties

    // MARK: Lifecycle

    static func instantiate() -> ResultViewController {
        return Storyboard.ResultViewController.instantiate(ResultViewController.self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
    }
}

// MARK: - Setup

extension ResultViewController {

    private func setupNavigation() {
        navigationItem.title = "変換結果"
    }
}
