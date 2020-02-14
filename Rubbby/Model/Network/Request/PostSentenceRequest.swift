//
//  PostSentenceRequest.swift
//  Rubbby
//
//  Created by 山田隼也 on 2020/02/14.
//  Copyright © 2020 Shunya Yamada. All rights reserved.
//

import Foundation
import Moya

extension HiraganaTranslationAPIService {
    struct PostSentenceRequest: HiraganaTranslationAPITargetType {
        
        // MARK: Response
        
        typealias Response = TranslationEntity
        
        // MARK: Properties
        
        let appId: String
        let sentence: String
        let outputType: TranslationType
        
        // MARK: API info
        
        var path: String {
            return "/hiragana"
        }
        
        var method: Moya.Method {
            return .post
        }
        
        var sampleData: Data {
            return Data()
        }
        
        var parameters: [String : Any] {
            return [
                "app_id": appId,
                "sentence": sentence,
                "output_type": outputType.rawValue
            ]
        }
        
        var parameterEncoding: URLEncoding {
            return .default
        }
        
        var task: Moya.Task {
            return .requestParameters(parameters: parameters, encoding: parameterEncoding)
        }
    }
}
