//
//  BatteryChargeView.swift
//  StudyProject11
//
//  Created by Nikolai Faustov on 18.09.2020.
//  Copyright © 2020 Nikolai Faustov. All rights reserved.
//

import UIKit

@IBDesignable
class BatteryChargeView: UIView {
    
    var batteryChargeColor: UIColor = .high
    
    @IBInspectable var batteryChargeLevel: CGFloat = 0.99 {
        didSet {
            assert(batteryChargeLevel >= 0 && batteryChargeLevel <= 1, "Use the value from 0.0 to 1.0")
            
            if batteryChargeLevel > 0.25 {
                batteryChargeColor = .high
            } else if batteryChargeLevel > 0.1 {
                batteryChargeColor = .medium
            } else {
                batteryChargeColor = .low
            }
        }
    }
    
    var cornerRadius: CGFloat = 15

    override func draw(_ rect: CGRect) {

        let batteryTopRect = CGRect(x: bounds.width * 0.33, y: 2, width: bounds.width * 0.34, height: bounds.height * 0.15 + cornerRadius)
        let batteryTopPath = UIBezierPath(roundedRect: batteryTopRect, cornerRadius: cornerRadius)

        let batteryRect = CGRect(x: 2, y: bounds.height * 0.15, width: bounds.width - 4, height: bounds.height * 0.85 - 2)
        let path = UIBezierPath(roundedRect: batteryRect, cornerRadius: cornerRadius)

        path.append(batteryTopPath)
        
        path.lineWidth = 3
        path.stroke()
        UIColor.white.setFill()
        path.fill()
        path.addClip()
        
        let fillRect = CGRect(x: 0, y: 0, width: bounds.width, height: (bounds.height - 2) * batteryChargeLevel)
        let transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        let chargeLevelRect = fillRect.applying(transform).offsetBy(dx: bounds.width, dy: bounds.height)
        let chargeLevelPath = UIBezierPath(rect: chargeLevelRect)
        
        batteryChargeColor.setFill()
        chargeLevelPath.fill()
    }
}

extension UIColor {
    static let low: UIColor = .red
    static let medium: UIColor = .yellow
    static let high: UIColor = .green
}
