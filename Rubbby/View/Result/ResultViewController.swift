//
//  ResultViewController.swift
//  Rubbby
//
//  Created by Yamada Shunya on 2020/02/18.
//  Copyright © 2020 Shunya Yamada. All rights reserved.
//

import UIKit
import RxCocoa

final class ResultViewController: DisposableViewController {

    // MARK: IBOutlet

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var backButton: Button!

    // MARK: Properties

    private var viewModel: ResultViewModel!

    private var dataSource: [ResultCellType] = [
        .output(translation: Translation(converted: "Converted", outputType: .hiragana)),
        .title(title: "変換履歴"),
        .history(translation: Translation(converted: "", outputType: .hiragana)),
        .history(translation: Translation(converted: "", outputType: .katakana)),
        .history(translation: Translation(converted: "", outputType: .hiragana)),
        .history(translation: Translation(converted: "", outputType: .hiragana))
    ]

    // MARK: Lifecycle

    static func configure(with translation: Translation) -> ResultViewController {
        let vc = Storyboard.ResultViewController.instantiate(ResultViewController.self)
        vc.viewModel = ResultViewModel(translation: translation)
        return vc
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setupTableView()
        bindViewModel()
    }
}

// MARK: - Setup

extension ResultViewController {

    private func setupNavigation() {
        navigationItem.title = "変換結果"
    }

    private func setupTableView() {
        tableView.separatorStyle = .none
        tableView.rowHeight = ResultCell.rowHeight
        tableView.estimatedRowHeight = ResultHistoryCell.rowHeight
        tableView.contentInset = UIEdgeInsets(top: 40, left: 0, bottom: 0, right: 0)
        tableView.register(ResultCell.nib, forCellReuseIdentifier: ResultCell.reuseIdentifier)
        tableView.register(ResultTitleCell.nib, forCellReuseIdentifier: ResultTitleCell.reuseIdentifier)
        tableView.register(ResultHistoryCell.nib, forCellReuseIdentifier: ResultHistoryCell.reuseIdentifier)
    }
}

// MARK: - ViewModel

extension ResultViewController {

    private func bindViewModel() {
        let input = ResultViewModel.Input(tapBackButtonSignal: backButton.rx.tap.asSignal())
        let output = viewModel.transform(input: input)

        output.dismiss
            .emit(onNext: { [weak self] in self?.dismiss(animated: true, completion: nil) })
            .disposed(by: disposeBag)
        output.dataSourceDriver
            .drive(tableView.rx.items) { tableView, _, element in
                switch element {
                case .output(let translation):
                    guard let cell = tableView
                        .dequeueReusableCell(withIdentifier: ResultCell.reuseIdentifier) as? ResultCell else { return UITableViewCell() }
                    cell.setupCell(outputText: translation.converted, originalText: "", tapCopyButtonRelay: output.tapCopyButtonRelay)
                    return cell
                case .title(let title):
                    guard let cell = tableView
                        .dequeueReusableCell(withIdentifier: ResultTitleCell.reuseIdentifier) as? ResultTitleCell else { return UITableViewCell() }
                    cell.setupCell(title: title)
                    return cell
                case .history:
                    guard let cell = tableView
                        .dequeueReusableCell(withIdentifier: ResultHistoryCell.reuseIdentifier) as? ResultHistoryCell else { return UITableViewCell() }
                    cell.setupCell(convertedText: "Converted", originalText: "Original", tapCopyButtonRelay: output.tapCopyButtonRelay)
                    return cell
                }
            }.disposed(by: disposeBag)
    }
}
