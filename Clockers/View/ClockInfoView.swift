//
//  ClockInfoView.swift
//  Clockers
//
//  Created by Christopher Clement Andreas on 03/12/19.
//  Copyright © 2019 Christopher Clement Andreas. All rights reserved.
//

import UIKit
import Foundation

class ClockInfoView: UIView {
    lazy var leftTitleLabel: UILabel = {
        let leftTitleLabel: UILabel = UILabel()
        leftTitleLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        leftTitleLabel.text = "Clock In"
        leftTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        leftTitleLabel.textColor = .gray
        
        return leftTitleLabel
    }()
    
    lazy var leftInfoLabel: UILabel = {
        let leftTitleLabel: UILabel = UILabel()
        leftTitleLabel.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        leftTitleLabel.text = "Left Info Text"
        leftTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        leftTitleLabel.textColor = .gray
        
        return leftTitleLabel
    }()
    
    lazy var rightTitleLabel: UILabel = {
        let rightTitleLabel: UILabel = UILabel()
        rightTitleLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        rightTitleLabel.text = "Clock Out"
        rightTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        rightTitleLabel.textColor = .gray
        
        return rightTitleLabel
    }()
    
    lazy var rightInfoLabel: UILabel = {
        let rightInfoLabel: UILabel = UILabel()
        rightInfoLabel.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        rightInfoLabel.text = "Right Info Text"
        rightInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        rightInfoLabel.textColor = .gray
        
        return rightInfoLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    func set(leftInfoText: String, rightInfoText: String) {
        leftInfoLabel.text = leftInfoText
        rightInfoLabel.text = rightInfoText
    }
    
    func setupView() {
        addSubview(leftTitleLabel)
        addSubview(leftInfoLabel)
        addSubview(rightTitleLabel)
        addSubview(rightInfoLabel)
        layoutViews()
    }
    
    func layoutViews() {
        let maximumWidth: CGFloat = UIScreen.main.bounds.width / 2 - 28
        NSLayoutConstraint.activate([
            leftTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 28),
            leftTitleLabel.topAnchor.constraint(equalTo: topAnchor),
            leftInfoLabel.topAnchor.constraint(equalTo: leftTitleLabel.bottomAnchor, constant: 8),
            leftInfoLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 28),
            rightTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -28),
            rightTitleLabel.topAnchor.constraint(equalTo: topAnchor),
            rightTitleLabel.widthAnchor.constraint(equalToConstant: maximumWidth),
            rightInfoLabel.topAnchor.constraint(equalTo: rightTitleLabel.bottomAnchor, constant: 8),
            rightInfoLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -28),
            rightInfoLabel.widthAnchor.constraint(equalToConstant: maximumWidth)
        ])
    }
}
