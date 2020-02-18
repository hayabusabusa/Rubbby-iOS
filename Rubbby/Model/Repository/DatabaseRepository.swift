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
    func saveHistory(_ history: HistoryEntity) -> Completable
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

    func saveHistory(_ history: HistoryEntity) -> Completable {
        return realmManager.save(history)
    }

    func getHistories() -> Single<[HistoryEntity]> {
        return realmManager.get(HistoryEntity.self)
    }
}
