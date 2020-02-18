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
    @IBOutlet private weak var backButton: Button!

    // MARK: Properties

    private var dataSource: [ResultCellType] = [
        .output(translation: Translation(converted: "Converted", outputType: .hiragana)),
        .title(title: "変換履歴"),
        .history(translation: Translation(converted: "", outputType: .hiragana)),
        .history(translation: Translation(converted: "", outputType: .katakana)),
        .history(translation: Translation(converted: "", outputType: .hiragana)),
        .history(translation: Translation(converted: "", outputType: .hiragana))
    ]

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
        return dataSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch dataSource[indexPath.row] {
        case .output:
            guard let cell = tableView
                .dequeueReusableCell(withIdentifier: ResultCell.reuseIdentifier, for: indexPath) as? ResultCell else { return UITableViewCell() }
            return cell
        case .title:
            guard let cell = tableView
                .dequeueReusableCell(withIdentifier: ResultTitleCell.reuseIdentifier, for: indexPath) as? ResultTitleCell else { return UITableViewCell() }
            return cell
        case .history:
            guard let cell = tableView
                .dequeueReusableCell(withIdentifier: ResultHistoryCell.reuseIdentifier, for: indexPath) as? ResultHistoryCell else { return UITableViewCell() }
            return cell
        }
    }
}
