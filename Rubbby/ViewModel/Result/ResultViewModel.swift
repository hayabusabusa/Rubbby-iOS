//
//  ResultViewModel.swift
//  Rubbby
//
//  Created by Yamada Shunya on 2020/02/18.
//  Copyright © 2020 Shunya Yamada. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class ResultViewModel {
    
    // MARK: Dependency
    
    // MARK: Propreties
    
    private let disposeBag = DisposeBag()
    
    // MARK: Initializer
}

extension ResultViewModel: ViewModelType {
    
    // MARK: I/O
    
    struct Input {
        
    }
    
    struct Output {
        
    }
    
    // MARK: Transform I/O
    
    func transform(input: ResultViewModel.Input) -> ResultViewModel.Output {
        return Output()
    }
}
