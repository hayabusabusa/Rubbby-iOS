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
        //let tapCopyButtonSignal: Signal<Void>
        let tapBackButtonSignal: Signal<Void>
    }

    struct Output {
        let dataSourceDriver: Driver<[ResultCellType]>
        let dismiss: Signal<Void>
    }

    // MARK: Transform I/O

    func transform(input: ResultViewModel.Input) -> ResultViewModel.Output {
        let dataSourceRelay: BehaviorRelay<[ResultCellType]> = .init(value: [])

        return Output(dataSourceDriver: dataSourceRelay.asDriver(),
                      dismiss: input.tapBackButtonSignal)
    }
}
