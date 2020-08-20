//
//  CustomButtonView.swift
//  StudyProject11
//
//  Created by Nikolai Faustov on 19.07.2020.
//  Copyright © 2020 Nikolai Faustov. All rights reserved.
//

import UIKit

@IBDesignable
class CustomButtonView: UIButton {
    
    @IBInspectable var cornerRadius: CGFloat = 12 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 2 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor = .black {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
}
