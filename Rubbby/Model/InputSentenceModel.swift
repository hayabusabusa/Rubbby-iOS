//
//  InputSentenceModel.swift
//  Rubbby
//
//  Created by Yamada Shunya on 2020/02/18.
//  Copyright © 2020 Shunya Yamada. All rights reserved.
//

import Foundation
import RxSwift

// MARK: - Interface

protocol InputSentenceModel {
    func postSentence(appId: String, sentence: String, outputType: TranslationType) -> Single<Translation>
}

// MARK: - Implementation

struct InputSentenceModelImpl: InputSentenceModel {

    // MARK: Dependency

    private let repository: HiraganaTranslationRepository

    // MARK: Initializer

    init(repository: HiraganaTranslationRepository = HiraganaTranslationRepositoryImpl()) {
        self.repository = repository
    }

    // MARK: API

    func postSentence(appId: String, sentence: String, outputType: TranslationType) -> Single<Translation> {
        return repository
            .postSentence(with: HiraganaTranslationAPIService.PostSentenceRequest(appId: appId, sentence: sentence, outputType: outputType))
            .translate(TranslationEntityTranslator())
    }
}
