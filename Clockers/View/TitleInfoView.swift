//
//  TitleInfoView.swift
//  Clockers
//
//  Created by Christopher Clement Andreas on 02/12/19.
//  Copyright © 2019 Christopher Clement Andreas. All rights reserved.
//

import UIKit
import Foundation

class TitleInfoView: UIView {
    lazy var leftTitleLabel: UILabel = {
        let title: UILabel = UILabel()
        title.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        title.text = "Left Title"
        title.translatesAutoresizingMaskIntoConstraints = false
        title.textColor = .gray
        
        return title
    }()
    var leftInfoLabel: UILabel = {
        let info: UILabel = UILabel()
        info.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        info.text = "Left Info"
        info.translatesAutoresizingMaskIntoConstraints = false
        info.textColor = .gray
        
        return info
    }()
    
    var rightTitleLabel: UILabel = {
        let title: UILabel = UILabel()
        title.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        title.text = "Right Title"
        title.translatesAutoresizingMaskIntoConstraints = false
        title.textColor = .gray
        title.textAlignment = .right
        
        return title
    }()
    
    var rightInfoLabel: UILabel = {
        let info: UILabel = UILabel()
        info.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        info.text = "Right Info"
        info.translatesAutoresizingMaskIntoConstraints = false
        info.textColor = .gray
        info.textAlignment = .right
        
        return info
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    convenience init(title: String, info: String) {
        self.init(frame: CGRect.zero)
        leftTitleLabel.text = title
        leftInfoLabel.text = info
        setupView()
    }
    
    func set(leftTitle: String, leftInfo: String, rightTitle: String, rightInfo: String) {
        leftTitleLabel.text = leftTitle
        leftInfoLabel.text = leftInfo
        rightTitleLabel.text = rightTitle
        rightInfoLabel.text = rightInfo
    }
    
    func setupView() {
        addSubview(leftTitleLabel)
        addSubview(leftInfoLabel)
        addSubview(rightTitleLabel)
        addSubview(rightInfoLabel)
        layoutViews()
    }
    
    func layoutViews() {
        NSLayoutConstraint.activate([
            leftTitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 6),
            leftTitleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 28),
            leftInfoLabel.topAnchor.constraint(equalTo: leftTitleLabel.bottomAnchor, constant: 4),
            leftInfoLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 28),
            rightTitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 6),
            rightTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -28),
            rightInfoLabel.topAnchor.constraint(equalTo: rightTitleLabel.bottomAnchor, constant: 4),
            rightInfoLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -28)
        ])
    }
}
