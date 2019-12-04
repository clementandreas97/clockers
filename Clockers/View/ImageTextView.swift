//
//  ImageTextView.swift
//  Clockers
//
//  Created by Christopher Clement Andreas on 03/12/19.
//  Copyright © 2019 Christopher Clement Andreas. All rights reserved.
//

import UIKit
import Foundation

class ImageTextView: UIView {
    lazy var imageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var textLabel: UILabel = {
        let textLabel: UILabel = UILabel()
        textLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        textLabel.text = "Text"
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.textColor = .gray
        textLabel.numberOfLines = 0
        
        return textLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    convenience init(imageString: String, text: String) {
        self.init(frame: CGRect.zero)
        imageView.image = UIImage(named: imageString)?.tint(color: Colors.gray)
        textLabel.text = text
        setupView()
    }
    
    func set(imageString: String, text: String) {
        imageView.image = UIImage(named: imageString)
        textLabel.text = text
        layoutViews()
    }
    
    func setupView() {
        addSubview(imageView)
        addSubview(textLabel)
        layoutViews()
    }
    
    func layoutViews() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 2),
            imageView.leadingAnchor.constraint(equalTo
                : leadingAnchor, constant: 28),
            imageView.widthAnchor.constraint(equalToConstant: 10),
            imageView.heightAnchor.constraint(equalToConstant: 10),
            textLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 8),
            textLabel.topAnchor.constraint(equalTo: topAnchor),
            textLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -28)
        ])
    }
}
