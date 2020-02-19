//
//  DisposableViewController.swift
//  Rubbby
//
//  Created by Yamada Shunya on 2020/02/17.
//  Copyright © 2020 Shunya Yamada. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import NVActivityIndicatorView

class DisposableViewController: UIViewController {

    let disposeBag = DisposeBag()
}

extension DisposableViewController: NVActivityIndicatorViewable {

}

extension Reactive where Base: DisposableViewController {

    var isLoading: Binder<Bool> {
        return Binder(self.base) { target, value in
            if value {
                target.startAnimating(CGSize(width: 24, height: 24), type: .lineScalePulseOutRapid, color: nil, backgroundColor: .clear)
            } else {
                target.stopAnimating()
            }
        }
    }
}
