//
//  ResultViewController.swift
//  Rubbby
//
//  Created by Yamada Shunya on 2020/02/18.
//  Copyright © 2020 Shunya Yamada. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import NotificationBanner

final class ResultViewController: DisposableViewController {

    // MARK: IBOutlet

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var backButton: Button!

    // MARK: Properties

    private var viewModel: ResultViewModel!

    // MARK: Lifecycle

    static func configure(with originalText: String, translation: Translation) -> ResultViewController {
        let vc = Storyboard.ResultViewController.instantiate(ResultViewController.self)
        vc.viewModel = ResultViewModel(dependency: ResultViewModel.Dependency(originalText: originalText,
                                                                              translation: translation))
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
        output.notificationBannerSignal
            .emit(onNext: { [weak self] content in self?.showBanner(content: content) })
            .disposed(by: disposeBag)
        output.setPasteboardSignal
            .emit(onNext: { [weak self] text in self?.setTextOnPasteboard(text: text) })
            .disposed(by: disposeBag)
        output.dataSourceDriver
            .drive(tableView.rx.items) { tableView, _, element in
                switch element {
                case let .output(originalText, translation):
                    guard let cell = tableView
                        .dequeueReusableCell(withIdentifier: ResultCell.reuseIdentifier) as? ResultCell else { return UITableViewCell() }

                    cell.setupCell(outputText: translation.converted, originalText: originalText)
                    _ = cell.copyButton.rx.tap
                        .takeUntil(cell.rx.sentMessage(#selector(UITableViewCell.prepareForReuse)))
                        .concat(Observable.never())
                        .bind(to: output.tapCopyButtonRelay)
                    return cell
                case .title(let title):
                    guard let cell = tableView
                        .dequeueReusableCell(withIdentifier: ResultTitleCell.reuseIdentifier) as? ResultTitleCell else { return UITableViewCell() }
                    cell.setupCell(title: title)
                    return cell
                case .history(let history):
                    guard let cell = tableView
                        .dequeueReusableCell(withIdentifier: ResultHistoryCell.reuseIdentifier) as? ResultHistoryCell else { return UITableViewCell() }
                    cell.setupCell(convertedText: history.converted, originalText: history.original)
                    return cell
                }
            }
        .disposed(by: disposeBag)
    }
}

// MARK: - NotificationBanner

extension ResultViewController {

    private func showBanner(content: BannerContent) {
        let banner = GrowingNotificationBanner(title: content.title, subtitle: content.message, style: content.style)
        banner.show()
    }
}

// MARK: - Pasteboard

extension ResultViewController {

    private func setTextOnPasteboard(text: String) {
        UIPasteboard.general.string = text
    }
}
