//
//  ImageDoubleTextView.swift
//  Clockers
//
//  Created by Christopher Clement Andreas on 03/12/19.
//  Copyright © 2019 Christopher Clement Andreas. All rights reserved.
//

import UIKit
import Foundation

class ImageDoubleTextView: UIView {
    lazy var imageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var leftTextLabel: UILabel = {
        let leftTextLabel: UILabel = UILabel()
        leftTextLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        leftTextLabel.text = "Left Text"
        leftTextLabel.translatesAutoresizingMaskIntoConstraints = false
        leftTextLabel.textColor = .gray
        
        return leftTextLabel
    }()
    
    lazy var rightTextLabel: UILabel = {
        let rightTextLabel: UILabel = UILabel()
        rightTextLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        rightTextLabel.text = "Right Text"
        rightTextLabel.translatesAutoresizingMaskIntoConstraints = false
        rightTextLabel.textColor = .gray
        
        return rightTextLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    func set(image: String, leftText: String, rightText: String, attrRightText: NSAttributedString? = nil) {
        leftTextLabel.text = leftText
        rightTextLabel.text = rightText
        if let rightAttr = attrRightText {
            rightTextLabel.text = nil
            rightTextLabel.attributedText = rightAttr
        }
    }
    
    func setupView() {
        addSubview(imageView)
        addSubview(leftTextLabel)
        addSubview(rightTextLabel)
        layoutViews()
    }
    
    func layoutViews() {
        let maximumWidth: CGFloat = UIScreen.main.bounds.width / 2 - 28
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 28),
            imageView.topAnchor.constraint(equalTo: topAnchor),
            leftTextLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 8),
            leftTextLabel.topAnchor.constraint(equalTo: topAnchor),
            rightTextLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -28),
            rightTextLabel.topAnchor.constraint(equalTo: topAnchor),
            rightTextLabel.widthAnchor.constraint(equalToConstant: maximumWidth)
        ])
    }
}
