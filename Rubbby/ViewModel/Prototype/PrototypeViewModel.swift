//
//  PrototypeViewModel.swift
//  Rubbby
//
//  Created by Yamada Shunya on 2020/02/14.
//  Copyright © 2020 Shunya Yamada. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class PrototypeViewModel {
    
    // MARK: Dependency
    
    // MARK: Propreties
    
    private let disposeBag = DisposeBag()
    
    // MARK: Initializer
}

extension PrototypeViewModel {
    
    // MARK: I/O
    
    struct Input {
        let editInputTextField: Driver<String>
    }
    
    struct Output {
        let translationDriver: Driver<String>
    }
    
    // MARK: Transform I/O
    
    func transform(input: PrototypeViewModel.Input) -> PrototypeViewModel.Output {
        let translationRelay: BehaviorRelay<String> = .init(value: "結果が表示されます")
        
        return Output(translationDriver: translationRelay.asDriver())
    }
}
