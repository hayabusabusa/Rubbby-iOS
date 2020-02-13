//
//  HiraganaTranslationAPI.swift
//  Rubbby
//
//  Created by 山田隼也 on 2020/02/13.
//  Copyright © 2020 Shunya Yamada. All rights reserved.
//

import Foundation
import Moya

enum HiraganaTranslationAPI {
    case postSentence(with: PostSentenceParams)
}

extension HiraganaTranslationAPI: TargetType {
    
    var baseURL: URL {
        guard let baseURL = URL(string: "https://labs.goo.ne.jp/api") else {
            fatalError("Couldn't be configured base URL")
        }
        return baseURL
    }
    
    var path: String {
        switch self {
        case .postSentence:
            return "/hiragana"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .postSentence:
            return .post
        }
    }
    
    var sampleData: Data {
        switch self {
        default:
            return Data()
        }
    }
    
    var parameters: [String: Any] {
        switch self {
        case .postSentence(let params):
            let parameters = [
                "sentence": params.sentence,
                "output_type": params.outputType.rawValue
            ] as [String: Any]
            return parameters
        }
    }
    
    var parameterEncoding: Moya.URLEncoding {
        switch self {
        case .postSentence:
            return .default
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .postSentence:
            return .requestParameters(parameters: parameters, encoding: parameterEncoding)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        default:
            return ["Content-type": "application/json"]
        }
    }
}
