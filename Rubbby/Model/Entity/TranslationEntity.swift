//
//  TranslationEntity.swift
//  Rubbby
//
//  Created by Yamada Shunya on 2020/02/13.
//  Copyright © 2020 Shunya Yamada. All rights reserved.
//

import Foundation

struct TranslationEntity: Decodable {
    let converted: String
    let outputType: TranslationType

    private enum CodingKeys: String, CodingKey {
        case converted
        case outputType = "output_type"
    }
}
