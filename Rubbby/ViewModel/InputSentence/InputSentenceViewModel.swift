//
//  InputSentenceViewModel.swift
//  Rubbby
//
//  Created by 山田隼也 on 2020/02/18.
//  Copyright © 2020 Shunya Yamada. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class InputSentenceViewModel {
    
    // MARK: Dependency
    
    // MARK: Properties
    
    // MARK: Initializer
}

extension InputSentenceViewModel: ViewModelType {
    
    // MARK: I/O
    
    struct Input {
        
    }
    
    struct Output {
        
    }
    
    // MARK: Transform I/O
    
    func transform(input: InputSentenceViewModel.Input) -> InputSentenceViewModel.Output {
        return Output()
    }
}
