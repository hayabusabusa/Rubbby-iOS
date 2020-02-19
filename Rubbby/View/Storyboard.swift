//
//  Storyboard.swift
//  Rubbby
//
//  Created by Yamada Shunya on 2020/02/17.
//  Copyright © 2020 Shunya Yamada. All rights reserved.
//

import UIKit

// NOTE: Storyboardのファイル名を使用するため、以下のルールを無効.
// swiftlint:disable identifier_name
enum Storyboard: String {
    case InputSentenceViewController
    case ResultViewController

    func instantiate<VC: UIViewController>(_: VC.Type, inBundle: Bundle? = nil) -> VC {
        guard let vc = UIStoryboard(name: self.rawValue, bundle: inBundle).instantiateInitialViewController() as? VC else {
            fatalError("Couldn't instantiate \(self.rawValue)")
        }
        return vc
    }
}
