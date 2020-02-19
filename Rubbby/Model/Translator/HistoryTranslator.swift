//
//  HistoryTranslator.swift
//  Rubbby
//
//  Created by 山田隼也 on 2020/02/19.
//  Copyright © 2020 Shunya Yamada. All rights reserved.
//

import Foundation

struct HistoryTranslator: Translator {
    typealias Input = [History]
    typealias Output = [ResultCellType]

    private let originalText: String
    private let translation: Translation

    func translate(_ input: [History]) -> [ResultCellType] {
        var rows: [ResultCellType] = [ResultCellType]()

        // NOTE: Append output
        rows.append(.output(originalText: originalText, translation: translation))

        // NOTE: Append histories
        if !input.isEmpty {
            rows.append(.title(title: "変換履歴"))
            rows.append(contentsOf: input.map { ResultCellType.history(history: $0) })
        }

        return rows
    }
}
