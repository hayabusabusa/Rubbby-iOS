//
//  ResultCellType.swift
//  Rubbby
//
//  Created by Yamada Shunya on 2020/02/18.
//  Copyright © 2020 Shunya Yamada. All rights reserved.
//

import Foundation

enum ResultCellType {
    case output(translation: Translation)
    case title(title: String)
    case history(translation: Translation)
}
