//
//  PrototypeViewController.swift
//  Rubbby
//
//  Created by Yamada Shunya on 2020/02/14.
//  Copyright © 2020 Shunya Yamada. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class PrototypeViewController: UIViewController {

    // MARK: IBOutlet

    @IBOutlet private weak var resultLabel: UILabel!
    @IBOutlet private weak var inputTextField: UITextField!
    @IBOutlet private weak var translateButton: UIButton!

    // MARK: Properties

    private let disposeBag = DisposeBag()
    private var viewModel: PrototypeViewModel!

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
}

// MARK: - ViewModel

extension PrototypeViewController {

    private func bindViewModel() {
        let viewModel = PrototypeViewModel()
        self.viewModel = viewModel

        let input = PrototypeViewModel.Input(tapTranslateButtonSignal: translateButton.rx.tap.asSignal())
        let output = viewModel.transform(input: input)

        inputTextField.rx.text
            .bind(to: output.inputTextFieldRelay)
            .disposed(by: disposeBag)
        output.translationDriver
            .drive(resultLabel.rx.text)
            .disposed(by: disposeBag)
    }
}
