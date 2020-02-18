//
//  ResultHistoryCell.swift
//  Rubbby
//
//  Created by Yamada Shunya on 2020/02/18.
//  Copyright © 2020 Shunya Yamada. All rights reserved.
//

import UIKit

class ResultHistoryCell: UITableViewCell {

    // MARK: IBOutlet

    @IBOutlet private weak var convertedTextLabel: UILabel!
    @IBOutlet private weak var originalTextLabel: UILabel!

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
}
