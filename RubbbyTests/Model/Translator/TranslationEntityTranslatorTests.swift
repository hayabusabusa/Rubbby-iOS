//
//  TranslationEntityTranslatorTests.swift
//  RubbbyTests
//
//  Created by Yamada Shunya on 2020/02/14.
//  Copyright © 2020 Shunya Yamada. All rights reserved.
//

import XCTest
@testable import Rubbby

class TranslationEntityTranslatorTests: XCTestCase {
    
    func test_TranslationEntityTranslatorの出力が正しく行われるかを確認() {
        XCTContext.runActivity(named: "Entityから画面表示用のオブジェクトが正しく生成できることを確認") { _ in
            let input = TranslationEntity(converted: "かんじが まざった さんぷる", outputType: .hiragana)
            let output = try? TranslationEntityTranslator().translate(input)
            
            XCTAssertNotNil(output, "`translate()`でエラーが発生したため、結果が`nil`です.")
            XCTAssertEqual(output?.converted, "かんじが まざった さんぷる", "`converted`の値が入力したEntityの値と一致しません.")
            XCTAssertEqual(output?.outputType, TranslationType.hiragana, "`outputType`の値が入力したEntityの値と一致しません.")
        }
    }
}
