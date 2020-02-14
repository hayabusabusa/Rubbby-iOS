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
    
    private let model: PrototypeModel
    
    // MARK: Propreties
    
    private let disposeBag = DisposeBag()
    
    // MARK: Initializer
    
    init(model: PrototypeModel = PrototypeModelImpl()) {
        self.model = model
    }
}

extension PrototypeViewModel {
    
    // MARK: I/O
    
    struct Input {
        let tapTranslateButtonSignal: Signal<Void>
    }
    
    struct Output {
        let inputTextFieldRelay: BehaviorRelay<String?>
        let translationDriver: Driver<String>
    }
    
    // MARK: Transform I/O
    
    func transform(input: PrototypeViewModel.Input) -> PrototypeViewModel.Output {
        let inputTextFieldRelay: BehaviorRelay<String?> = .init(value: "")
        let translationRelay: BehaviorRelay<String> = .init(value: "結果が表示されます")
        
        let postSentenceSignal = model.postSentence(appId: appID, sentence: inputTextFieldRelay.value ?? "", outputType: .hiragana)
            .asSignal { error -> SharedSequence<SignalSharingStrategy, Translation> in
                print(error)
                return .empty()
            }
        
        input.tapTranslateButtonSignal
            .flatMap { postSentenceSignal }
            .map { $0.converted }
            .emit(to: translationRelay)
            .disposed(by: disposeBag)
        
        return Output(inputTextFieldRelay: inputTextFieldRelay,
                      translationDriver: translationRelay.asDriver())
    }
}
