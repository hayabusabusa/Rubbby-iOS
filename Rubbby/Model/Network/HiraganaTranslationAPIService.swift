//
//  HiraganaTranslationAPIService.swift
//  Rubbby
//
//  Created by 山田隼也 on 2020/02/14.
//  Copyright © 2020 Shunya Yamada. All rights reserved.
//

import Foundation
import Moya
import RxMoya
import RxSwift

protocol HiraganaTranslationAPI {
    func request<T: HiraganaTranslationAPITargetType>(_ request: T) -> Single<T.Response>
}

final class HiraganaTranslationAPIService: HiraganaTranslationAPI {

    // MARK: Singletone

    static let shared: HiraganaTranslationAPIService = .init()

    // MARK: Properties

    private let provider: MoyaProvider<MultiTarget> = .init()

    // MARK: Initializer

    private init() {}

    // MARK: Request

    func request<T: HiraganaTranslationAPITargetType>(_ request: T) -> Single<T.Response> {
        let target = MultiTarget(request)
        return provider.rx.request(target)
            .filterSuccessfulStatusCodes()
            .map(T.Response.self)
    }
}
