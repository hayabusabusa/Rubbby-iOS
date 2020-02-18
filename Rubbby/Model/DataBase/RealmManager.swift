//
//  RealmManager.swift
//  Rubbby
//
//  Created by 山田隼也 on 2020/02/19.
//  Copyright © 2020 Shunya Yamada. All rights reserved.
//

import Foundation
import RxSwift
import RealmSwift

// MARK: - Interface

protocol RealmManagerProtocol {
    func save<T: Object>(_ object: T) -> Completable
    func get<T: Object>(_ objectType: T.Type) -> Single<[T]>
}

// MARK: - Implementation

struct RealmManager: RealmManagerProtocol {

    // MARK: Properties

    private let realm: Realm

    // MARK: Initializer

    init() {
        do {
            realm = try Realm()
        } catch {
            fatalError("Could not instantiate Realm: \(error)")
        }
    }

    // MARK: Save

    func save<T: Object>(_ object: T) -> Completable {
        return Completable.create { observer in
            do {
                try self.realm.write {
                    self.realm.add(object)
                }
                observer(.completed)
            } catch {
                observer(.error(error))
            }
            return Disposables.create()
        }
    }
    
    func get<T: Object>(_ objectType: T.Type) -> Single<[T]> {
        return Single.create { observer in
            let objects = self.realm.objects(objectType)
            observer(.success(objects.map { $0 }))
            return Disposables.create()
        }
    }
}
