//
//  Translator.swift
//  Rubbby
//
//  Created by Yamada Shunya on 2020/02/14.
//  Copyright © 2020 Shunya Yamada. All rights reserved.
//

import Foundation
import RxSwift

protocol Translator {
    associatedtype Input
    associatedtype Output
    func translate(_ input: Input) throws -> Output
}

extension ObservableType {
    func translate<T: Translator>(with translator: T) -> Observable<T.Output> where Self.Element == T.Input {
        return map { try translator.translate($0) }
    }
}

extension Collection {
    func translate<T: Translator>(with translator: T) throws -> [T.Output] where Self.Iterator.Element == T.Input {
        return try map { try translator.translate($0) }
    }
}

extension PrimitiveSequenceType where Self.Trait == SingleTrait {
    func translate<T: Translator>(_ translator: T) -> PrimitiveSequence<Trait, T.Output> where Self.Element == T.Input {
        return primitiveSequence.map { try translator.translate($0) }
    }
}
