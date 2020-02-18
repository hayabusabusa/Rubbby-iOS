//
//  HistoryEntityTranslator.swift
//  Rubbby
//
//  Created by 山田隼也 on 2020/02/19.
//  Copyright © 2020 Shunya Yamada. All rights reserved.
//

import Foundation

struct HistoryEntityTranslator: Translator {
    typealias Input = HistoryEntity
    typealias Output = History
    
    func translate(_ input: HistoryEntity) throws -> History {
        return History(original: input.original,
                       converted: input.converted)
    }
}
