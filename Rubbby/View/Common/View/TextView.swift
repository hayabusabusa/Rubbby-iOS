//
//  TextView.swift
//  Rubbby
//
//  Created by 山田隼也 on 2020/02/17.
//  Copyright © 2020 Shunya Yamada. All rights reserved.
//

import UIKit

class TextView: UITextView {

    // MARK: IBInspectable

    @IBInspectable var padding: CGFloat = 0.0
    @IBInspectable var cornerRadius: CGFloat = 0.0
    @IBInspectable var borderWidth: CGFloat = 0.0
    @IBInspectable var borderColor: UIColor = .clear
    @IBInspectable var placeholder: String = ""

    // MARK: Properties

    private var placeholderLabel = UILabel()
    private var notificationToken: NSObjectProtocol?

    // MARK: Override

    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    deinit {
        if let notificationToken = notificationToken {
            NotificationCenter.default.removeObserver(notificationToken)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        commonInit()
    }

    // MARK: Common init

    private func commonInit() {
        isExclusiveTouch = true
        textContainerInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        layer.cornerRadius = cornerRadius
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor

        setupPlaceholderLabel()
    }

    // MARK: Setup

    private func setupPlaceholderLabel() {
        placeholderLabel.text = placeholder
        placeholderLabel.font = font
        placeholderLabel.numberOfLines = 1
        placeholderLabel.textColor = UIColor.lightGray.withAlphaComponent(3)
        placeholderLabel.textAlignment = .left
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(placeholderLabel)

        NSLayoutConstraint.activate([
            placeholderLabel.topAnchor.constraint(equalTo: topAnchor, constant: padding + 2.0),
            placeholderLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: padding + 4.0),
            placeholderLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding + 4.0)
        ])

        notificationToken = NotificationCenter.default.addObserver(forName: UITextView.textDidChangeNotification, object: self, queue: nil) { [weak self] _ in
            guard let text = self?.text else { return }
            self?.placeholderLabel.isHidden = !text.isEmpty
        }
    }
}
