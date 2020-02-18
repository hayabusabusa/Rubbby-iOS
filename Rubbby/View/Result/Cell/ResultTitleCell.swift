//
//  ResultTitleCell.swift
//  Rubbby
//
//  Created by Yamada Shunya on 2020/02/18.
//  Copyright © 2020 Shunya Yamada. All rights reserved.
//

import UIKit

class ResultTitleCell: UITableViewCell {

    // MARK: IBOutlet

    @IBOutlet private weak var titleLabel: UILabel!

    // MARK: Properties

    static let reuseIdentifier = "ResultTitleCell"
    static let rowHeight: CGFloat = UITableView.automaticDimension
    static let estimatedRowHeitht: CGFloat = 44
    static var nib: UINib {
        return UINib(nibName: "ResultTitleCell", bundle: nil)
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
