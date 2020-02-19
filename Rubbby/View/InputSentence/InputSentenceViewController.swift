//
//  InputSentenceViewController.swift
//  Rubbby
//
//  Created by Yamada Shunya on 2020/02/17.
//  Copyright © 2020 Shunya Yamada. All rights reserved.
//

import UIKit
import RxCocoa
import NotificationBanner

final class InputSentenceViewController: DisposableViewController {

    // MARK: IBOutlet

    @IBOutlet private weak var typeSegmentedControl: UISegmentedControl!
    @IBOutlet private weak var outputTypeLabel: UILabel!
    @IBOutlet private weak var clearButton: UIButton!
    @IBOutlet private weak var inputTextView: UITextView!
    @IBOutlet private weak var translateButton: UIButton!
    @IBOutlet private weak var usageButton: UIButton!
    @IBOutlet private weak var usageTextView: UITextView!

    // MARK: Properties

    private var viewModel: InputSentenceViewModel!

    // MARK: Lifecycle

    static func instantiate() -> InputSentenceViewController {
        return Storyboard.InputSentenceViewController.instantiate(InputSentenceViewController.self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setupSegmentedControl()
        bindViews()
        bindViewModel()
    }
}

// MARK: - Setup

extension InputSentenceViewController {

    private func setupNavigation() {
        navigationItem.title = "変換する"
    }

    private func setupSegmentedControl() {
        typeSegmentedControl.selectedSegmentTintColor = .primary
        typeSegmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.primary], for: .normal)
        typeSegmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
    }
}

// MARK: - ViewModel

extension InputSentenceViewController {

    private func bindViews() {
        inputTextView.rx.text.orEmpty
            .map { !$0.isEmpty }
            .bind(to: translateButton.rx.isEnabled)
            .disposed(by: disposeBag)
    }

    private func bindViewModel() {
        let viewModel = InputSentenceViewModel()
        self.viewModel = viewModel

        let input = InputSentenceViewModel.Input(changeTypeSegmentedControlSignal: typeSegmentedControl.rx.value.asSignal(onErrorSignalWith: .empty()),
                                                 tapClearButtonSignal: clearButton.rx.tap.asSignal(onErrorSignalWith: .empty()),
                                                 inputTextViewDriver: inputTextView.rx.text.orEmpty.asDriver(),
                                                 tapTranslateButtonSignal: translateButton.rx.tap.asSignal(onErrorSignalWith: .empty()),
                                                 tapUsegeButtonSignal: usageButton.rx.tap.asSignal(onErrorSignalWith: .empty()))
        let output = viewModel.transform(input: input)

        output.isLoading
            .emit(to: rx.isLoading)
            .disposed(by: disposeBag)
        output.notificationBannerSignal
            .emit(onNext: { [weak self] content in self?.showBanner(content: content) })
            .disposed(by: disposeBag)
        output.clearTextSignal
            .emit(to: inputTextView.rx.text.orEmpty)
            .disposed(by: disposeBag)
        output.outputTypeDriver
            .drive(outputTypeLabel.rx.text)
            .disposed(by: disposeBag)
        output.usageButtonTitleDriver
            .drive(usageButton.rx.title())
            .disposed(by: disposeBag)
        output.hideUsageTextViewDriver
            .drive(onNext: { [weak self] isHidden in self?.usageTextViewExpandAnimation(isHidden: isHidden) })
            .disposed(by: disposeBag)
        output.presentResult
            .emit(onNext: { [weak self] dependency in self?.presentResult(dependency: dependency) })
            .disposed(by: disposeBag)
    }
}

// MARK: - Error message

extension InputSentenceViewController {

    private func showBanner(content: BannerContent) {
        let banner = GrowingNotificationBanner(title: content.title, subtitle: content.message, style: content.style)
        banner.show()
    }
}

// MARK: - Animation

extension InputSentenceViewController {

    private func usageTextViewExpandAnimation(isHidden: Bool) {
        UIView.animate(withDuration: 0.3) {
            self.usageTextView.alpha = isHidden ? 0 : 1
            self.usageTextView.isHidden = isHidden
        }
    }
}

// MARK: - Transition

extension InputSentenceViewController {

    private func presentResult(dependency: ResultViewModel.Dependency) {
        let vc = NavigationController(rootViewController: ResultViewController.configure(with: dependency.originalText,
                                                                                         translation: dependency.translation))
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        present(vc, animated: true, completion: nil)
    }
}
