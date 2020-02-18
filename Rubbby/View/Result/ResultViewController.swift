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
        setupTableView()
    }
}

// MARK: - Setup

extension ResultViewController {

    private func setupNavigation() {
        navigationItem.title = "変換結果"
    }

    private func setupTableView() {
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsets(top: 40, left: 0, bottom: 0, right: 0)
        tableView.register(ResultCell.nib, forCellReuseIdentifier: ResultCell.reuseIdentifier)
        tableView.register(ResultTitleCell.nib, forCellReuseIdentifier: ResultTitleCell.reuseIdentifier)
        tableView.register(ResultHistoryCell.nib, forCellReuseIdentifier: ResultHistoryCell.reuseIdentifier)
    }
}

// MARK: - TableView dataSource

extension ResultViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ResultCell.reuseIdentifier, for: indexPath) as? ResultCell else {
            return UITableViewCell()
        }
        return cell
    }
}
