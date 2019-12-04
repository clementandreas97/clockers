//
//  Colors.swift
//  Clockers
//
//  Created by Christopher Clement Andreas on 03/12/19.
//  Copyright © 2019 Christopher Clement Andreas. All rights reserved.
//

import UIKit
import Foundation

struct Colors {
    static let progressBarGray: UIColor = UIColor(red: 196/255, green: 196/255, blue: 196/255, alpha: 1.00)
    static let gray: UIColor = UIColor(red: 119/255, green: 119/255, blue: 119/255, alpha: 1.00)
    static let lightGray: UIColor = UIColor(red: 229/255, green: 229/255, blue: 229/255, alpha: 1.00)
    static let darkGray: UIColor = UIColor(red: 127/255, green: 127/255, blue: 127/255, alpha: 1.00)
    static let darkerGray: UIColor = UIColor(red: 64/255, green: 64/255, blue: 64/255, alpha: 1.00)
}

extension UIImage {
    func tint(color: UIColor) -> UIImage? {
        var newImage: UIImage?
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        if let context: CGContext = UIGraphicsGetCurrentContext(),
            let cgImage = cgImage {
            context.translateBy(x: 0, y: size.height)
            context.scaleBy(x: 1, y: -1)
            let rect: CGRect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
            
            context.setBlendMode(.normal)
            context.draw(cgImage, in: rect)
            context.setBlendMode(.sourceIn)
            color.setFill()
            context.fill(rect)
            
            newImage = UIGraphicsGetImageFromCurrentImageContext()
        }
        UIGraphicsEndImageContext()
        return newImage
    }
}
