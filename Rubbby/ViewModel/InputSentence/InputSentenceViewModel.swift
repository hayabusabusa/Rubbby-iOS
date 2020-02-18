//
//  InputSentenceViewModel.swift
//  Rubbby
//
//  Created by 山田隼也 on 2020/02/18.
//  Copyright © 2020 Shunya Yamada. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class InputSentenceViewModel {

    // MARK: Dependency

    private let model: InputSentenceModel

    // MARK: Properties

    private let disposeBag = DisposeBag()

    // MARK: Initializer

    init(model: InputSentenceModel = InputSentenceModelImpl()) {
        self.model = model
    }
}

extension InputSentenceViewModel: ViewModelType {

    // MARK: I/O

    struct Input {
        let changeTypeSegmentedControlSignal: Signal<Int>
        let tapClearButtonSignal: Signal<Void>
        let inputTextViewDriver: Driver<String>
        let tapTranslateButtonSignal: Signal<Void>
        let tapUsegeButtonSignal: Signal<Void>
    }

    struct Output {
        let clearTextSignal: Signal<String>
        let outputTypeDriver: Driver<String>
        let hideUsageTextViewDriver: Driver<Bool>
        let presentResult: Signal<Translation>
    }

    // MARK: Transform I/O

    func transform(input: InputSentenceViewModel.Input) -> InputSentenceViewModel.Output {
        let inputTextRelay: BehaviorRelay<String> = .init(value: "")
        let outputTypeRelay: BehaviorRelay<String> = .init(value: "ひらがな")
        let hideUsageTextViewRelay: BehaviorRelay<Bool> = .init(value: true)
        let presentResultRelay: PublishRelay<Translation> = .init()

        input.inputTextViewDriver
            .drive(inputTextRelay)
            .disposed(by: disposeBag)
        // NOTE: `SegmentedControl`の値が変更された際に、変換先を表示するラベルに表示する値を流す.
        input.changeTypeSegmentedControlSignal.map { $0 == 0 ? "ひらがな" : "カタカナ" }
            .emit(to: outputTypeRelay)
            .disposed(by: disposeBag)
        // NOTE: 変換ボタンが押された際にAPIへPOSTのリクエストを行う.
        input.tapTranslateButtonSignal
            .withLatestFrom(input.inputTextViewDriver)
            .emit(onNext: { [weak self] sentence in
                guard let self = self else { return }
                let outputType = outputTypeRelay.value == "ひらがな" ? TranslationType.hiragana : TranslationType.katakana
                self.model.postSentence(appId: appID, sentence: sentence, outputType: outputType)
                    .subscribe(onSuccess: { translation in
                        presentResultRelay.accept(translation)
                    }, onError: { error in
                        print(error)
                    })
                    .disposed(by: self.disposeBag)
            })
            .disposed(by: disposeBag)
        // NOTE: 使い方を表示するボタンがタップされた際に `TextView` を表示、非表示にする値を流す.
        input.tapUsegeButtonSignal.map { !hideUsageTextViewRelay.value }
            .emit(to: hideUsageTextViewRelay)
            .disposed(by: disposeBag)

        return Output(clearTextSignal: input.tapClearButtonSignal.map { "" },
                      outputTypeDriver: outputTypeRelay.asDriver(),
                      hideUsageTextViewDriver: hideUsageTextViewRelay.asDriver(),
                      presentResult: presentResultRelay.asSignal())
    }
}
