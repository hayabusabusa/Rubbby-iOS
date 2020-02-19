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

    let originalText: String
    let translation: Translation

    func translate(_ input: [History]) -> [ResultCellType] {
        let sortedInput = input.sorted(by: { $1.date < $0.date })
        var rows: [ResultCellType] = [ResultCellType]()

        // NOTE: Append output
        rows.append(.output(originalText: originalText, translation: translation))

        // NOTE: Append histories
        if !input.isEmpty {
            rows.append(.title(title: "変換履歴"))
            rows.append(contentsOf: sortedInput.map { ResultCellType.history(history: $0) })
        }

        return rows
    }
}
