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
        let notificationBannerSignal: Signal<BannerContent>
        let tapCopyButtonRelay: PublishRelay<Void>
        let setPasteboardSignal: Signal<String>
        let dataSourceDriver: Driver<[ResultCellType]>
    }

    // MARK: Transform I/O

    func transform(input: ResultViewModel.Input) -> ResultViewModel.Output {
        let notificationBannerRelay: PublishRelay<BannerContent> = .init()
        let tapCopyButtonRelay: PublishRelay<Void> = .init()
        let dataSourceRelay: BehaviorRelay<[ResultCellType]> = .init(value: [])

        model.saveHistory(History(date: Date(), original: originalText, converted: translation.converted))
            .andThen(model.getHistories())
            .translate(HistoryTranslator(originalText: originalText, translation: translation))
            .subscribe(onSuccess: { dataSource in
                dataSourceRelay.accept(dataSource)
            }, onError: { _ in
                notificationBannerRelay.accept(BannerContent(title: "エラー", message: "履歴の保存、読み込みに失敗しました。", style: .danger))
            })
            .disposed(by: disposeBag)

        let setPasteboardSignal = tapCopyButtonRelay
            .map { [weak self] in self?.translation.converted ?? "" }
            .asSignal(onErrorSignalWith: .empty())
        return Output(dismiss: input.tapBackButtonSignal,
                      notificationBannerSignal: notificationBannerRelay.asSignal(),
                      tapCopyButtonRelay: tapCopyButtonRelay,
                      setPasteboardSignal: setPasteboardSignal,
                      dataSourceDriver: dataSourceRelay.asDriver())
    }
}
