//
//  HiraganaTranslationRepository.swift
//  Rubbby
//
//  Created by Yamada Shunya on 2020/02/14.
//  Copyright © 2020 Shunya Yamada. All rights reserved.
//

import Foundation
import RxSwift

// MARK: - Interface

protocol HiraganaTranslationRepository {
    func postSentence(with request: HiraganaTranslationAPIService.PostSentenceRequest) -> Single<TranslationEntity>
}

// MARK: - Implementation

struct HiraganaTranslationRepositoryImpl: HiraganaTranslationRepository {

    // MARK: Dependency

    private let api: HiraganaTranslationAPI

    // MARK: Initializer

    init(api: HiraganaTranslationAPI = HiraganaTranslationAPIService.shared) {
        self.api = api
    }

    // MARK: API

    func postSentence(with request: HiraganaTranslationAPIService.PostSentenceRequest) -> Single<TranslationEntity> {
        return api.request(request)
    }
}
