//
//  ViewableTranslator.swift
//  Rubbby
//
//  Created by 山田隼也 on 2020/02/19.
//  Copyright © 2020 Shunya Yamada. All rights reserved.
//

import Foundation
import RxCocoa

protocol ViewableTranslator {
    associatedtype Input
    associatedtype Output
    func translate(_ input: Input) -> Output
}

extension SharedSequenceConvertibleType {
    func translate<T: ViewableTranslator>(with translator: T) -> SharedSequence<Self.SharingStrategy, T.Output> where Self.Element == T.Input {
        return map { translator.translate($0) }
    }
}
