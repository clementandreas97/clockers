//
//  CircularButton.swift
//  Clockers
//
//  Created by Christopher Clement Andreas on 03/12/19.
//  Copyright © 2019 Christopher Clement Andreas. All rights reserved.
//

import UIKit
import Foundation

class CircularButton: UIView {
    var onTapButton: (() -> Void)?
    var isClockingIn: Bool = false
    
    lazy var backgroundView: UIView = {
        let backgroundView: UIView = UIView()
        backgroundView.isAccessibilityElement = true
        backgroundView.isUserInteractionEnabled = true
        backgroundView.accessibilityIdentifier = "background_area"
        backgroundView.addGestureRecognizer(
            UITapGestureRecognizer(
                target: self,
                action: #selector(onTapView)
            )
        )
        backgroundView.backgroundColor = Colors.darkGray
        backgroundView.layer.cornerRadius = 70
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        
        return backgroundView
    }()
    
    lazy var contentView: UIView = {
        let contentView: UIView = UIView()
        contentView.isAccessibilityElement = true
        contentView.isUserInteractionEnabled = true
        contentView.accessibilityIdentifier = "content_area"
        contentView.addGestureRecognizer(
            UITapGestureRecognizer(
                target: self,
                action: #selector(onTapView)
            )
        )
        contentView.backgroundColor = Colors.lightGray
        contentView.layer.cornerRadius = 52.5
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        return contentView
    }()
    
    lazy var buttonLabel: UILabel = {
        let buttonLabel: UILabel = UILabel()
        buttonLabel.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        buttonLabel.text = "Clock In"
        buttonLabel.translatesAutoresizingMaskIntoConstraints = false
        buttonLabel.textColor = Colors.gray
        
        return buttonLabel
    }()
    
    @objc func onTapView() {
        onTapButton?()
    }
    
    func toggleClockingIn() {
        isClockingIn = !isClockingIn
        buttonLabel.text = isClockingIn ? "Clock Out" : "Clock In"
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    func setupView() {
        addSubview(backgroundView)
        addSubview(contentView)
        addSubview(buttonLabel)
        layoutViews()
    }
    
    func layoutViews() {
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: topAnchor),
            backgroundView.centerXAnchor.constraint(equalTo: centerXAnchor),
            backgroundView.widthAnchor.constraint(equalToConstant: 140),
            backgroundView.heightAnchor.constraint(equalToConstant: 140),
            contentView.centerXAnchor.constraint(equalTo: centerXAnchor),
            contentView.centerYAnchor.constraint(equalTo: centerYAnchor),
            contentView.widthAnchor.constraint(equalToConstant: 105),
            contentView.heightAnchor.constraint(equalToConstant: 105),
            buttonLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            buttonLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}
