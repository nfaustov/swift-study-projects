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
    
    @IBInspectable private var cornerRadius: CGFloat = 12
    @IBInspectable private var borderWidth: CGFloat = 2
    @IBInspectable private var borderColor: UIColor = .black
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = cornerRadius
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor
    }
}
