//
//  ResultHistoryCell.swift
//  Rubbby
//
//  Created by Yamada Shunya on 2020/02/18.
//  Copyright © 2020 Shunya Yamada. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ResultHistoryCell: UITableViewCell {

    // MARK: IBOutlet

    @IBOutlet private weak var convertedTextLabel: UILabel!
    @IBOutlet private weak var originalTextLabel: UILabel!
    @IBOutlet private weak var copyButton: UIButton!

    // MARK: Properties

    static let reuseIdentifier = "ResultHistoryCell"
    static let rowHeight: CGFloat = UITableView.automaticDimension
    static let estimatedRowHeight: CGFloat = 88
    static var nib: UINib {
        return UINib(nibName: "ResultHistoryCell", bundle: nil)
    }

    // MARK: Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    // MARK: Setup

    func setupCell(convertedText: String, originalText: String, tapCopyButtonRelay: PublishRelay<Void>) {
        convertedTextLabel.text = convertedText
        originalTextLabel.text = originalText
        _ = copyButton.rx.tap
            .takeUntil(rx.sentMessage(#selector(UITableViewCell.prepareForReuse)))
            .concat(Observable.never())
            .bind(to: tapCopyButtonRelay)
    }
}
