//
//  Const.swift
//  Clinic Administration
//
//  Created by Nikolai Faustov on 09.11.2020.
//

import UIKit

enum Const {
    enum Color {
        static let white = #colorLiteral(red: 0.9960784314, green: 0.9960784314, blue: 0.9921568627, alpha: 1)
        static let lightGray = #colorLiteral(red: 0.8941176471, green: 0.9019607843, blue: 0.8901960784, alpha: 1)
        static let gray = #colorLiteral(red: 0.8156862745, green: 0.8156862745, blue: 0.7725490196, alpha: 1)
        static let darkGray = #colorLiteral(red: 0.6274509804, green: 0.631372549, blue: 0.5803921569, alpha: 1)
        static let brown = #colorLiteral(red: 0.4588235294, green: 0.3921568627, blue: 0.2901960784, alpha: 1)
        static let red = #colorLiteral(red: 0.3960784314, green: 0.1568627451, blue: 0.02352941176, alpha: 1)
        static let chocolate = #colorLiteral(red: 0.2352941176, green: 0.2, blue: 0.1450980392, alpha: 1)
    }
    
    enum Shape {
        static let smallCornerRadius: CGFloat = 5
        static let mediumCornerRadius: CGFloat = 10
        static let largeCornerRadius: CGFloat = 15
    }
    
    enum Font {
        static let black = UIFont(name: "Roboto-Black", size: 17)
        static let bold = UIFont(name: "Roboto-Bold", size: 17)
        static let medium = UIFont(name: "Roboto-Medium", size: 17)
        static let regular = UIFont(name: "Roboto-Regular", size: 17)
        static let light = UIFont(name: "Roboto-Light", size: 17)
        static let thin = UIFont(name: "Roboto-Thin", size: 17)
    }
}
