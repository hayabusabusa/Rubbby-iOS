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

    private let translation: Translation

    // MARK: Propreties

    private let disposeBag = DisposeBag()

    // MARK: Initializer

    init(translation: Translation) {
        self.translation = translation
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

        dataSourceRelay.accept([.output(translation: translation)])

        let setPasteboardSignal = tapCopyButtonRelay
            .map { [weak self] in self?.translation.converted ?? "" }
            .asSignal(onErrorSignalWith: .empty())
        return Output(dismiss: input.tapBackButtonSignal,
                      tapCopyButtonRelay: tapCopyButtonRelay,
                      setPasteboardSignal: setPasteboardSignal,
                      dataSourceDriver: dataSourceRelay.asDriver())
    }
}
