//
//  HiraganaTranslationAPITargetType.swift
//  Rubbby
//
//  Created by 山田隼也 on 2020/02/14.
//  Copyright © 2020 Shunya Yamada. All rights reserved.
//

import Foundation
import Moya

protocol HiraganaTranslationAPITargetType: TargetType {
    associatedtype Response: Decodable

    var parameters: [String: Any] { get }
    var parameterEncoding: Moya.URLEncoding { get }
}

extension HiraganaTranslationAPITargetType {
    var baseURL: URL {
        return URL(string: "https://labs.goo.ne.jp/api")!
    }

    var headers: [String : String]? {
        return nil
    }
}
