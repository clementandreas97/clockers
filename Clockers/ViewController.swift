//
//  ViewController.swift
//  Clockers
//
//  Created by Christopher Clement Andreas on 02/12/19.
//  Copyright © 2019 Christopher Clement Andreas. All rights reserved.
//

import UIKit
extension String {
    func heightForWidth(_ width: CGFloat, font: UIFont) -> CGFloat {
        
        let size: CGSize = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        
        let rect: CGRect = (self as NSString).boundingRect(
            with: size,
            options: [NSStringDrawingOptions.usesLineFragmentOrigin,
                      NSStringDrawingOptions.usesFontLeading],
            attributes: [NSAttributedString.Key.font: font],
            context: nil)
        
        return ceil(rect.height)
    }
}

class ViewController: UIViewController {
    var titleView = TitleInfoView()
    var addressView = ImageTextView()
    var managerView = ImageDoubleTextView()
    var contactNumberView = ImageDoubleTextView()
    var clockInfoView = ClockInfoView()
    var button = CircularButton()
    
    var isClockingIn: Bool = true
    
    var locationString: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
        ClockService.shared.login(completionHandler: { [weak self] (clientInfo, position, wageAmount, wageType, location, manager) in
            guard let ws = self else { return }
            ws.set(clientInfo: clientInfo, position: position, wageAmount: wageAmount, wageType: wageType, location: location, manager: manager)
            ws.setupViews()
        })
    }
    
    func setupNavBar() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.backgroundColor = .clear
        self.navigationController?.navigationBar.isTranslucent = true
    }
    
    func set(clientInfo: [String: Any], position: [String: Any], wageAmount: String, wageType: String, location: [String: Any], manager: [String: Any]) {
        guard let clientName = clientInfo["name"] as? String,
            let positionName = position["name"] as? String,
            let addressObj = location["address"] as? [String: Any],
            let managerName = manager["name"] as? String,
            let managerPhone = manager["phone"] as? String else { return }
        
        let formattedWageType = wageType.replacingOccurrences(of: "[^A-Za-z0-9]+", with: " ", options: [.regularExpression])

        if let address = addressObj["street_1"] as? String {
            locationString = address
        }
        
        let attributes: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13),
            NSAttributedString.Key.foregroundColor: Colors.gray,
            NSAttributedString.Key.strikethroughStyle: 0,
            NSAttributedString.Key.underlineStyle:
               true,
            NSAttributedString.Key.paragraphStyle: NSMutableParagraphStyle()
        ]
        
        titleView.set(leftTitle: positionName, leftInfo: clientName, rightTitle: "Rp \(wageAmount)", rightInfo: formattedWageType)
        addressView.set(imageString: "", text: locationString)
        managerView.set(image: "", leftText: "Location Manager", rightText: managerName)
        contactNumberView.set(image: "", leftText: "Contact Number", rightText: managerPhone, attrRightText: NSAttributedString(string: managerPhone, attributes: attributes))
        clockInfoView.set(leftInfoText: "_")
        clockInfoView.set(rightInfoText: "_")
        button.onTapButton = { [weak self] in
            guard let ws = self else { return }
            let loadingScreen: LoadingScreen = LoadingScreen()
            loadingScreen.set(isClockingIn: ws.button.buttonLabel.text == "Clock In")
            loadingScreen.set(toggleClocking: { [weak self] in
                let date = Date()
                let calendar = Calendar.current
                let hour = calendar.component(.hour, from: date)
                let minutes = calendar.component(.minute, from: date)
                let dateString: String = "\(hour):\(minutes)"
                let dateFormatter = DateFormatter()
                dateFormatter.locale = Locale(identifier: "en_US_POSIX")
                dateFormatter.dateFormat = "H:mm"
                var convertedTime: String = "_"
                if let inDate = dateFormatter.date(from: dateString) {
                    dateFormatter.dateFormat = "h:mm a"
                    convertedTime = dateFormatter.string(from:inDate)
                }
                if ws.button.buttonLabel.text == "Clock In" {
                    ws.clockInfoView.set(leftInfoText: convertedTime)
                    ws.button.toggleClockingIn()
                } else {
                    ws.clockInfoView.set(rightInfoText: convertedTime)
                    ws.button.isHidden = true
                }
                
            })
            ws.navigationController?.present(UINavigationController(rootViewController: loadingScreen), animated: true, completion: nil)
        }
    }
    
    func setupViews() {
        view.addSubview(titleView)
        view.addSubview(addressView)
        view.addSubview(managerView)
        view.addSubview(contactNumberView)
        view.addSubview(clockInfoView)
        view.addSubview(button)
        layoutViews()
    }
    
    func layoutViews() {
        titleView.translatesAutoresizingMaskIntoConstraints = false
        addressView.translatesAutoresizingMaskIntoConstraints = false
        managerView.translatesAutoresizingMaskIntoConstraints = false
        contactNumberView.translatesAutoresizingMaskIntoConstraints = false
        clockInfoView.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        
        var safeAreaHeight: CGFloat = UIApplication.shared.statusBarFrame.height
        
        if let navbarHeight = navigationController?.navigationBar.frame.height {
            safeAreaHeight += navbarHeight
        }
        
        let maxAddressHeight = max(20, locationString.heightForWidth(UIScreen.main.bounds.width - 74, font: UIFont.systemFont(ofSize: 13)))
        
        NSLayoutConstraint.activate([
            titleView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            titleView.topAnchor.constraint(equalTo: view.topAnchor, constant: safeAreaHeight),
            titleView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            titleView.heightAnchor.constraint(equalToConstant: 60),
            addressView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            addressView.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 8),
            addressView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            addressView.heightAnchor.constraint(equalToConstant: maxAddressHeight),
            managerView.topAnchor.constraint(equalTo: addressView.bottomAnchor, constant: 12),
            managerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            managerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            managerView.heightAnchor.constraint(equalToConstant: 18),
            contactNumberView.topAnchor.constraint(equalTo: managerView.bottomAnchor, constant: 12),
            contactNumberView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contactNumberView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contactNumberView.heightAnchor.constraint(equalToConstant: 18),
            clockInfoView.topAnchor.constraint(equalTo: contactNumberView.bottomAnchor, constant: 28),
            clockInfoView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            clockInfoView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            clockInfoView.heightAnchor.constraint(equalToConstant: 54),
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            button.topAnchor.constraint(equalTo: clockInfoView.bottomAnchor, constant: 60),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            button.heightAnchor.constraint(equalToConstant: 140)
        ])
    }
}

