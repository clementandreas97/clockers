//
//  LoadingScreen.swift
//  Clockers
//
//  Created by Christopher Clement Andreas on 04/12/19.
//  Copyright © 2019 Christopher Clement Andreas. All rights reserved.
//

import UIKit
import Foundation

struct Const {
    static let maxTime: Float = 3.0
}

class LoadingScreen: UIViewController {
    var currentTime: Float = 0.0
    var titleLabel: UILabel = {
        let titleLabel: UILabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        titleLabel.text = "Clocking In..."
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = .white
        
        return titleLabel
    }()
    
    var progressView: UIProgressView = {
        let progressView: UIProgressView = UIProgressView()
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.setProgress(0.0, animated: true)
        progressView.progressTintColor = Colors.progressBarGray
        progressView.backgroundColor = .white
        
        return progressView
    }()
    
    var cancelLabel: UILabel = {
        let cancelLabel: UILabel = UILabel()
        cancelLabel.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        let underlineStyling: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15, weight: .bold),
            NSAttributedString.Key.foregroundColor: Colors.gray,
            NSAttributedString.Key.strikethroughStyle: 0,
            NSAttributedString.Key.underlineStyle:
               true,
            NSAttributedString.Key.paragraphStyle: NSMutableParagraphStyle()
        ]
        cancelLabel.attributedText = NSAttributedString(string: "Cancel", attributes: underlineStyling)
        cancelLabel.textAlignment = .center
        cancelLabel.translatesAutoresizingMaskIntoConstraints = false
        cancelLabel.textColor = .white
        cancelLabel.isUserInteractionEnabled = true
        cancelLabel.isAccessibilityElement = true
        cancelLabel.accessibilityIdentifier = "cancel_label"
        cancelLabel.addGestureRecognizer(
            UITapGestureRecognizer(
                target: self,
                action: #selector(onTapCancel)
            )
        )
        
        return cancelLabel
    }()
    
    var cancelTapArea: UIView = {
        let cancelTapArea: UIView = UIView()
        cancelTapArea.isUserInteractionEnabled = true
        cancelTapArea.isAccessibilityElement = true
        cancelTapArea.accessibilityIdentifier = "cancel_tap_area"
        cancelTapArea.backgroundColor = .clear
        cancelTapArea.translatesAutoresizingMaskIntoConstraints = false
        cancelTapArea.addGestureRecognizer(
            UITapGestureRecognizer(
                target: self,
                action: #selector(onTapCancel)
            )
        )
        
        return cancelTapArea
    }()
    
    @objc func onTapCancel() {
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        view.backgroundColor = Colors.darkerGray
        setupViews()
        timeProgressBar()
    }
    
    func setupNavBar() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.backgroundColor = .clear
        self.navigationController?.navigationBar.isTranslucent = true
    }
    
    func timeProgressBar() {
        progressView.setProgress(currentTime, animated: true)
        perform(#selector(updateProgress), with: nil, afterDelay: 1.0)
    }
    
    @objc func updateProgress() {
        currentTime += 1.0
        progressView.progress = currentTime / Const.maxTime
        
        if currentTime < Const.maxTime {
            perform(#selector(updateProgress), with: nil, afterDelay: 1.0)
        } else {
            navigationController?.dismiss(animated: true, completion: nil)
        }
    }
    
    func setupViews() {
        view.addSubview(progressView)
        view.addSubview(titleLabel)
        view.addSubview(cancelLabel)
        view.addSubview(cancelTapArea)
        view.bringSubviewToFront(cancelTapArea)
        layoutViews()
    }
    
    func layoutViews() {
        NSLayoutConstraint.activate([
            progressView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            progressView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            progressView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 112),
            progressView.heightAnchor.constraint(equalToConstant: 20),
            titleLabel.bottomAnchor.constraint(equalTo: progressView.topAnchor, constant: -24),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 112),
            titleLabel.heightAnchor.constraint(equalToConstant: 24),
            cancelTapArea.topAnchor.constraint(equalTo: progressView.bottomAnchor, constant: 24),
            cancelTapArea.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cancelTapArea.widthAnchor.constraint(equalToConstant: 51),
            cancelTapArea.heightAnchor.constraint(equalToConstant: 24),
            cancelLabel.topAnchor.constraint(equalTo: progressView.bottomAnchor, constant: 24),
            cancelLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cancelLabel.widthAnchor.constraint(equalToConstant: 51),
            cancelLabel.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
}
