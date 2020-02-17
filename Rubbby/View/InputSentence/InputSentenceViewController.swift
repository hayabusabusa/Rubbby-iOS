//
//  InputSentenceViewController.swift
//  Rubbby
//
//  Created by Yamada Shunya on 2020/02/17.
//  Copyright © 2020 Shunya Yamada. All rights reserved.
//

import UIKit
import RxCocoa

final class InputSentenceViewController: DisposableViewController {

    // MARK: IBOutlet

    @IBOutlet private weak var typeSegmentedControl: UISegmentedControl!
    @IBOutlet private weak var closeButton: UIButton!
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

    private func bindViewModel() {
        let viewModel = InputSentenceViewModel()
        self.viewModel = viewModel
    }
}
