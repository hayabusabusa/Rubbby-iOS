//
//  HistoryEntity.swift
//  Rubbby
//
//  Created by 山田隼也 on 2020/02/18.
//  Copyright © 2020 Shunya Yamada. All rights reserved.
//

import Foundation
import RealmSwift

class HistoryEntity: Object {
    @objc dynamic var date: Date = Date()
    @objc dynamic var original: String = ""
    @objc dynamic var converted: String = ""
}
