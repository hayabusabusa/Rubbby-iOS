//
//  TranslationEntityTests.swift
//  RubbbyTests
//
//  Created by Yamada Shunya on 2020/02/13.
//  Copyright © 2020 Shunya Yamada. All rights reserved.
//

import XCTest
@testable import Rubbby

class TranslationEntityTests: XCTestCase {
    
    func test_TranslationEntityのデコードを確認() {
        XCTContext.runActivity(named: "`output_typ`が`hiragana`のレスポンスをデコードできることを確認") { _  in
            let data = resource(name: .hiraganaTypeResponse, resourceType: .json)
            let translationEntity = try? JSONDecoder().decode(TranslationEntity.self, from: data)
            XCTAssertNotNil(translationEntity, "デコードに失敗しています.")
            XCTAssertEqual(translationEntity?.converted, "かんじが まざった さんぷるの れすぽんすです", "`converted`の結果が正しくありません.")
            XCTAssertEqual(translationEntity?.outputType, TranslationType.hiragana, "`outputType`の結果が正しくありません.")
        }
        
        XCTContext.runActivity(named: "`output_typ`が`katakana`のレスポンスをデコードできることを確認") { _ in
            let data = resource(name: .katakanaTypeResponse, resourceType: .json)
            let translationEntity = try? JSONDecoder().decode(TranslationEntity.self, from: data)
            XCTAssertNotNil(translationEntity, "デコードに失敗しています.")
            XCTAssertEqual(translationEntity?.converted, "カンジガ マザッタ サンプルノ レスポンスデス", "`converted`の結果が正しくありません.")
            XCTAssertEqual(translationEntity?.outputType, TranslationType.katakana, "`outputType`の結果が正しくありません.")
        }
    }
}
