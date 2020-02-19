//
//  DatabaseRepository.swift
//  Rubbby
//
//  Created by 山田隼也 on 2020/02/19.
//  Copyright © 2020 Shunya Yamada. All rights reserved.
//

import Foundation
import RxSwift

// MARK: - Interface

protocol DatabaseRepository {
    func saveHistory(_ history: History) -> Completable
    func getHistories() -> Single<[HistoryEntity]>
}

// MARK: - Implementation

struct DatabaseRepositoryImpl: DatabaseRepository {

    // MARK: Dependency

    private let realmManager: RealmManagerProtocol

    // MARK: Initialzer

    init(realmManager: RealmManagerProtocol = RealmManager()) {
        self.realmManager = realmManager
    }

    // MARK: Realm

    func saveHistory(_ history: History) -> Completable {
        // NOTE: Create entity.
        let historyEntity = HistoryEntity()
        historyEntity.converted = history.converted
        historyEntity.original = history.original
        return realmManager.save(historyEntity)
    }

    func getHistories() -> Single<[HistoryEntity]> {
        return realmManager.get(HistoryEntity.self)
    }
}
