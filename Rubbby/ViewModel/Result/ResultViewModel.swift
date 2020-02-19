//
//  ResultViewModel.swift
//  Rubbby
//
//  Created by Yamada Shunya on 2020/02/18.
//  Copyright © 2020 Shunya Yamada. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class ResultViewModel {

    // MARK: Dependency

    typealias Dependency = (originalText: String, translation: Translation)

    private let model: ResultModel
    private let originalText: String
    private let translation: Translation

    // MARK: Propreties

    private let disposeBag = DisposeBag()

    // MARK: Initializer

    init(dependency: Dependency, model: ResultModel = ResultModelImpl()) {
        self.model = model
        originalText = dependency.originalText
        translation = dependency.translation
    }
}

extension ResultViewModel: ViewModelType {

    // MARK: I/O

    struct Input {
        let tapBackButtonSignal: Signal<Void>
    }

    struct Output {
        let dismiss: Signal<Void>
        let tapCopyButtonRelay: PublishRelay<Void>
        let setPasteboardSignal: Signal<String>
        let dataSourceDriver: Driver<[ResultCellType]>
    }

    // MARK: Transform I/O

    func transform(input: ResultViewModel.Input) -> ResultViewModel.Output {
        let tapCopyButtonRelay: PublishRelay<Void> = .init()
        let dataSourceRelay: BehaviorRelay<[ResultCellType]> = .init(value: [])

        model.saveHistory(History(original: originalText, converted: translation.converted))
            .andThen(model.getHistories())
            .subscribe(onSuccess: { histories in
                print(histories)
            }, onError: { error in
                print(error)
            })
            .disposed(by: disposeBag)

        dataSourceRelay.accept([.output(originalText: originalText, translation: translation)])

        let setPasteboardSignal = tapCopyButtonRelay
            .map { [weak self] in self?.translation.converted ?? "" }
            .asSignal(onErrorSignalWith: .empty())
        return Output(dismiss: input.tapBackButtonSignal,
                      tapCopyButtonRelay: tapCopyButtonRelay,
                      setPasteboardSignal: setPasteboardSignal,
                      dataSourceDriver: dataSourceRelay.asDriver())
    }
}
