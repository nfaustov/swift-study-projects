//
//  ViewController.swift
//  StudyProject6.3
//
//  Created by Nikolai Faustov on 29.03.2020.
//  Copyright © 2020 Nikolai Faustov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var resultLabel: UILabel!
    
    @IBOutlet weak var num1TextField: UITextField!
    
    @IBOutlet weak var num2TextField: UITextField!
    
    @IBOutlet weak var operationTextField: UITextField!
    
    enum Operator: String {
        case addition = "+"
        case subtraction = "-"
        case multiplication = "*"
        case quotient = "/"
        case power = "^"
        case min = "min"
        case max = "max"
        
        func apply(_ num1: Double, _ num2: Double) -> Double {
            switch self {
                case .addition: return num1 + num2
                case .subtraction: return num1 - num2
                case .multiplication: return num1 * num2
                case .quotient: return num1 / num2
                case .power: return pow(num1, num2)
                case .min: return num1 > num2 ? num2 : num1
                case .max: return num2 > num1 ? num1 : num2
                }
        }
    }
    
    @IBAction func calculate() {
        if let num1 = Double(num1TextField.text ?? ""), let num2 = Double(num2TextField.text ?? "") {
            if let operation = Operator(rawValue: operationTextField.text ?? "") {
            resultLabel.text = "\(operation.apply(num1, num2))"
            }
            else {
                resultLabel.text = "Введите корректный оператор"
            }
        }
        else {
            resultLabel.text = "Введите число"
        }
    }
}

