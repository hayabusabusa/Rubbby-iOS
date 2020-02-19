//
//  ResultModel.swift
//  Rubbby
//
//  Created by 山田隼也 on 2020/02/19.
//  Copyright © 2020 Shunya Yamada. All rights reserved.
//

import Foundation
import RxSwift

// MARK: - Interface

protocol ResultModel {
    func saveHistory(_ history: History) -> Completable
    func getHistories() -> Single<[History]>
}

// MARK: - Implementation

struct ResultModelImpl: ResultModel {

    // MARK: Dependency

    private let repository: DatabaseRepository

    // MARK: Initializer

    init(repository: DatabaseRepository = DatabaseRepositoryImpl()) {
        self.repository = repository
    }

    // MARK: Realm

    func saveHistory(_ history: History) -> Completable {
        return repository.saveHistory(history)
    }

    func getHistories() -> Single<[History]> {
        return repository.getHistories()
            .translate(HistoryEntityTranslator())
    }

}
