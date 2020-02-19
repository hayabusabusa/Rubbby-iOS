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
        let isLoading: Signal<Bool>
        let errorMessageDriver: Signal<String>
        let clearTextSignal: Signal<String>
        let outputTypeDriver: Driver<String>
        let usageButtonTitleDriver: Driver<String>
        let hideUsageTextViewDriver: Driver<Bool>
        let presentResult: Signal<ResultViewModel.Dependency>
    }

    // MARK: Transform I/O

    func transform(input: InputSentenceViewModel.Input) -> InputSentenceViewModel.Output {
        let isLoadingRelay: PublishRelay<Bool> = .init()
        let errorMessageRelay: PublishRelay<String> = .init()
        let inputTextRelay: BehaviorRelay<String> = .init(value: "")
        let outputTypeRelay: BehaviorRelay<String> = .init(value: "ひらがな")
        let hideUsageTextViewRelay: BehaviorRelay<Bool> = .init(value: true)
        let presentResultRelay: PublishRelay<ResultViewModel.Dependency> = .init()

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

                isLoadingRelay.accept(true) // Show indicator
                let outputType = outputTypeRelay.value == "ひらがな" ? TranslationType.hiragana : TranslationType.katakana
                self.model.postSentence(appId: appID, sentence: sentence, outputType: outputType)
                    .subscribe(onSuccess: { translation in
                        isLoadingRelay.accept(false) // Hide indicator
                        presentResultRelay.accept(ResultViewModel.Dependency(originalText: inputTextRelay.value,
                                                                             translation: translation))
                    }, onError: { _ in
                        isLoadingRelay.accept(false) // Hide indicator
                        errorMessageRelay.accept("エラーが発生しました。\n通信状況や入力した文章をもう一度確認してください。") // Show error
                    })
                    .disposed(by: self.disposeBag)
            })
            .disposed(by: disposeBag)
        // NOTE: 使い方を表示するボタンがタップされた際に `TextView` を表示、非表示にする値を流す.
        input.tapUsegeButtonSignal.map { !hideUsageTextViewRelay.value }
            .emit(to: hideUsageTextViewRelay)
            .disposed(by: disposeBag)

        let usageButtonTitleDriver = hideUsageTextViewRelay.map { $0 ? "表示する" : "閉じる" }
            .asDriver(onErrorDriveWith: .empty())

        return Output(isLoading: isLoadingRelay.asSignal(),
                      errorMessageDriver: errorMessageRelay.asSignal(),
                      clearTextSignal: input.tapClearButtonSignal.map { "" },
                      outputTypeDriver: outputTypeRelay.asDriver(),
                      usageButtonTitleDriver: usageButtonTitleDriver,
                      hideUsageTextViewDriver: hideUsageTextViewRelay.asDriver(),
                      presentResult: presentResultRelay.asSignal())
    }
}
