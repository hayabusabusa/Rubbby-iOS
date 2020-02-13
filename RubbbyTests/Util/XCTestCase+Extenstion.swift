//
//  XCTestCase+Extenstion.swift
//  RubbbyTests
//
//  Created by Yamada Shunya on 2020/02/13.
//  Copyright © 2020 Shunya Yamada. All rights reserved.
//

import XCTest

extension XCTestCase {
    
    enum ResourceName: String {
        case hiraganaTypeResponse = "hiragana_type_response"
        case katakanaTypeResponse = "katakana_type_response"
    }
    
    enum ResourceType: String {
        case json
    }
    
    func resource(name: ResourceName, resourceType: ResourceType) -> Data {
        guard let path = Bundle(for: type(of: self)).url(forResource: name.rawValue, withExtension: resourceType.rawValue),
            let data = try? Data(contentsOf: path) else {
                fatalError("\(name).json wasn't found")
        }
        return data
    }
}

