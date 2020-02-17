//
//  InputSentenceViewController.swift
//  Rubbby
//
//  Created by Yamada Shunya on 2020/02/17.
//  Copyright © 2020 Shunya Yamada. All rights reserved.
//

import UIKit

final class InputSentenceViewController: DisposableViewController {

    // MARK: IBOutlet

    // MARK: Properties

    // MARK: Lifecycle

    static func instantiate() -> InputSentenceViewController {
        return Storyboard.InputSentenceViewController.instantiate(InputSentenceViewController.self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
