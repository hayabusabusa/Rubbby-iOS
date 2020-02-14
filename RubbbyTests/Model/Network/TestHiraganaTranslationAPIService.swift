//
//  TestHiraganaTranslationAPIService.swift
//  RubbbyTests
//
//  Created by Yamada Shunya on 2020/02/14.
//  Copyright © 2020 Shunya Yamada. All rights reserved.
//

import Foundation
import RxSwift
@testable import Rubbby

final class TestHiraganaTranslationAPIService: HiraganaTranslationAPI {
    
    // MARK: Stub
    
    private var stub: (request: Any, response: Any)?
    
    func addStub<T: HiraganaTranslationAPITargetType>(request: T, response: Single<T.Response>) {
        stub = (request: request, response: response)
    }
    
    // MARK: Request
    
    func request<T: HiraganaTranslationAPITargetType>(_ request: T) -> Single<T.Response> {
        guard let stub = self.stub,
            let response = stub.request as? T.Response else { return Single.error(RxError.unknown) }
        self.stub = nil
        return Single.just(response)
    }
}
