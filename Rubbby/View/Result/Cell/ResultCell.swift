//
//  ResultCell.swift
//  Rubbby
//
//  Created by Yamada Shunya on 2020/02/18.
//  Copyright © 2020 Shunya Yamada. All rights reserved.
//

import UIKit

class ResultCell: UITableViewCell {

    // MARK: IBOutlet
    
    @IBOutlet private weak var copyButton: UIButton!
    @IBOutlet private weak var outputTextView: UITextView!
    @IBOutlet private weak var originalTextView: UITextView!
    
    // MARK: Properties
    
    static let reuseIdentifier = "ResultCell"
    static let rowHeight: CGFloat = UITableView.automaticDimension
    static let estimatedHeight: CGFloat = 172
    static var nib: UINib {
        return UINib(nibName: "ResultCell", bundle: nil)
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
