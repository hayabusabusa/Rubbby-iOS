//
//  TranslationEntityTranslator.swift
//  Rubbby
//
//  Created by Yamada Shunya on 2020/02/14.
//  Copyright © 2020 Shunya Yamada. All rights reserved.
//

import Foundation

struct TranslationEntityTranslator: Translator {
    typealias Input = TranslationEntity
    typealias Output = Translation

    func translate(_ input: TranslationEntity) throws -> Translation {
        return Translation(converted: input.converted, outputType: input.outputType)
    }
}
